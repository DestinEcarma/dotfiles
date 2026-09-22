import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Networking

import qs.config
import qs.modules.components
import qs.services

Item {
    id: root

    property WifiDevice wifiDevice: Networking.devices.values.find(device => device.type === DeviceType.Wifi) ?? null
    property bool wifiDeviceAvailable: wifiDevice !== null

    readonly property var allNetworks: wifiDevice?.networks.values ?? []
    readonly property var knownNetworks: allNetworks.filter(network => network.known)
    readonly property var availableNetworks: allNetworks.filter(network => !network.known)

    property bool scannerRequested: false

    signal backRequested

    implicitWidth: 400
    implicitHeight: columnContent.implicitHeight

    onWifiDeviceChanged: updateScanner()

    Connections {
        target: Networking

        function onWifiEnabledChanged() {
            root.updateScanner();
        }
    }

    Connections {
        target: FocusService.grab

        function onActiveChanged() {
            if (!FocusService.grab.active) {
                root.scannerRequested = false;
                root.updateScanner();
            }
        }
    }

    function updateScanner() {
        if (!wifiDevice)
            return;

        wifiDevice.scannerEnabled = scannerRequested && Networking.wifiEnabled;
    }

    function requireSecret(security) {
        return security === WifiSecurityType.WpaPsk || security === WifiSecurityType.Wpa2Psk || security === WifiSecurityType.Sae;
    }

    ColumnLayout {
        id: columnContent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: Config.spacingM

        RowLayout {
            spacing: Config.spacingM

            IconButton {
                icon: "arrow_back_ios_new"
                nudgeX: -1
                onActivated: {
                    root.scannerRequested = false;
                    root.updateScanner();
                    root.backRequested();
                }
            }

            StyledText {
                text: "Wi-Fi"
                font.bold: true
                font.pixelSize: Config.fontSizeL
                Layout.fillWidth: true
            }

            ToggleSwitch {
                id: toggleSwitch
                visible: root.wifiDeviceAvailable
                padding: 0
                checked: Networking.wifiEnabled
                onToggled: Networking.wifiEnabled = !Networking.wifiEnabled
            }
        }

        StyledText {
            visible: !root.wifiDeviceAvailable
            text: "No Wi-Fi device found"
            font.pixelSize: Config.fontSizeS
            opacity: 0.75
            Layout.alignment: Qt.AlignHCenter
        }

        ColumnLayout {
            visible: root.wifiDeviceAvailable && Networking.wifiEnabled
            spacing: Config.spacingM

            ColumnLayout {
                visible: root.knownNetworks.length > 0
                spacing: Config.spacingM

                StyledText {
                    text: "Known networks"
                    font.pixelSize: Config.fontSizeS
                    opacity: 0.75
                }

                ListView {
                    Layout.fillWidth: true
                    implicitHeight: Math.min(contentHeight, 131)
                    spacing: Config.spacingXS
                    model: root.knownNetworks
                    clip: true

                    delegate: NetworkListItem {
                        property bool waitingForResult: false
                        onClicked: {
                            if (network.stateChanging || waitingForResult)
                                return;

                            waitingForResult = true;

                            network.connectedChanged.connect(onConnectedChanged);
                            network.connectionFailed.connect(onConnectionFailed);

                            if (network.connected)
                                network.disconnect();
                            else
                                network.connect();
                        }

                        function disconnectNetworkSignals() {
                            if (!network)
                                return;

                            waitingForResult = false;

                            network.connectedChanged.disconnect(onConnectedChanged);
                            network.connectionFailed.disconnect(onConnectionFailed);
                        }

                        function onConnectedChanged() {
                            if (!network)
                                return;
                            disconnectNetworkSignals();
                        }

                        function onConnectionFailed(reason) {
                            if (!network)
                                return;
                            disconnectNetworkSignals();

                            if (reason === ConnectionFailReason.NoSecrets) {
                                pskDialog.open(network);
                            }
                        }
                    }
                }
            }

            RowLayout {
                StyledText {
                    text: root.wifiDevice?.scannerEnabled ? "Scanning" : "Scan available networks"
                    font.pixelSize: Config.fontSizeS
                    opacity: 0.75
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    IconText {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 1
                        visible: root.wifiDevice?.scannerEnabled ?? false

                        text: "progress_activity"
                        font.pixelSize: Config.iconSizeXS
                        opacity: 0.75

                        RotationAnimator on rotation {
                            from: 0
                            to: 360
                            duration: 1000
                            loops: Animation.Infinite
                            running: root.wifiDevice?.scannerEnabled ?? false
                        }
                    }
                }

                IconButton {
                    implicitWidth: 24
                    implicitHeight: 24
                    icon: root.wifiDevice?.scannerEnabled ? "sensors_off" : "sensors"
                    iconText.font.pixelSize: Config.iconSizeS
                    onActivated: {
                        root.scannerRequested = !root.scannerRequested;
                        root.updateScanner();
                    }
                }
            }

            StyledText {
                visible: root.scannerRequested && root.availableNetworks.length === 0
                text: "No networks found yet…"
                font.pixelSize: Config.fontSizeS
                opacity: 0.5
            }

            ListView {
                Layout.fillWidth: true
                visible: root.scannerRequested || root.availableNetworks.length > 0
                implicitHeight: contentHeight
                spacing: Config.spacingXS
                model: root.availableNetworks

                delegate: NetworkListItem {
                    onClicked: {
                        if (network.connected || network.stateChanging)
                            return;

                        if (root.requireSecret(network.security)) {
                            pskDialog.open(network);
                            return;
                        }

                        network.connect();
                    }
                }
            }
        }
    }

    Item {
        id: pskDialog

        property bool opened: false
        property var network: null

        property bool _renderVisible: false
        property bool _failed: false
        property bool _connecting: network ? network.state === ConnectionState.Connecting : false
        property bool _validPsk: passwordField.text.length >= 8 && passwordField.text.length <= 63

        anchors.fill: parent
        visible: _renderVisible
        opacity: opened ? 1 : 0
        z: 1000

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents: false
        }

        Rectangle {
            color: "#000000"
            opacity: 0.25
            width: root.width + Config.spacingL * 2
            height: root.height + Config.spacingL * 2
            x: -Config.spacingL
            y: -Config.spacingL
            radius: Config.radiusL
        }

        Rectangle {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            width: 300
            height: pskDialogColumnContent.implicitHeight + Config.spacingM * 2

            color: Colors.surfaceContainerLow
            radius: Config.radiusM

            ColumnLayout {
                id: pskDialogColumnContent
                anchors.fill: parent
                anchors.margins: Config.spacingM

                RowLayout {
                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        IconButton {
                            icon: "close"
                            disabled: pskDialog._connecting
                            onActivated: pskDialog.close()
                            color: Colors.surfaceContainerHigh
                            hoveredColor: Colors.surfaceContainerHighest
                        }
                    }

                    IconButton {
                        icon: "check"
                        disabled: !pskDialog._validPsk || pskDialog._connecting
                        color: Colors.secondary
                        hoveredColor: Colors.secondaryContainer
                        iconText.color: {
                            if (disabled)
                                return Colors.textOnSurfaceVariant;
                            return hovered ? Colors.textOnSecondaryContainer : Colors.textOnSecondary;
                        }
                        onActivated: pskDialog.connect(passwordField.text)
                    }
                }

                StyledText {
                    text: {
                        if (!pskDialog.network)
                            return "Password";
                        return pskDialog._connecting ? "Joining..." : `Join "${pskDialog.network.name}"`;
                    }
                    font.bold: true
                    color: Colors.textOnSurface
                }

                StyledText {
                    text: "Enter the password to join this Wi-Fi network."
                    font.pixelSize: Config.fontSizeS
                    opacity: 0.75
                    color: Colors.textOnSurface
                }

                TextField {
                    id: passwordField
                    Layout.fillWidth: true
                    echoMode: TextInput.Password
                    focus: true
                    color: Colors.textOnSurface

                    leftPadding: Config.spacingM
                    rightPadding: Config.spacingM
                    topPadding: Config.spacingS
                    bottomPadding: Config.spacingS

                    background: Rectangle {
                        color: Colors.surfaceContainerHigh
                        radius: Config.radiusM
                    }

                    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            event.accepted = true;
                            pskDialog.connect(passwordField.text);
                        }
                    }
                }

                StyledText {
                    id: textFailed
                    visible: pskDialog._failed
                    text: pskDialog.network ? `Incorrect password for "${pskDialog.network.name}"` : "This is a test"
                    font.pixelSize: Config.fontSizeS
                    opacity: 0.75
                    color: Colors.error

                    Timer {
                        id: failedTimer
                        interval: 5000
                        repeat: false
                        running: false
                        onTriggered: pskDialog._failed = false
                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration: Config.animationFast
                    }
                }
            }
        }

        function open(targetNetwork) {
            if (!targetNetwork)
                return;

            network = targetNetwork;

            failedTimer.stop();
            passwordField.clear();
            passwordField.forceActiveFocus();

            if (root.wifiDevice)
                root.wifiDevice.networks.objectRemovedPre.connect(onNetworksChanged);

            _renderVisible = true;
            opened = true;
        }

        function close() {
            if (!opened && !_renderVisible)
                return;

            opened = false;
            failedTimer.stop();

            if (root.wifiDevice)
                root.wifiDevice.networks.objectRemovedPre.disconnect(onNetworksChanged);

            fadeOutTimer.restart();
        }

        function connect(psk) {
            if (!network || _connecting || !_validPsk)
                return;

            disconnectNetworkSignals();
            network.connectedChanged.connect(onConnectedChanged);
            network.connectionFailed.connect(onConnectionFailed);

            network.connectWithPsk(psk);
        }

        function disconnectNetworkSignals() {
            if (!network)
                return;

            network.connectedChanged.disconnect(onConnectedChanged);
            network.connectionFailed.disconnect(onConnectionFailed);
        }

        function onConnectedChanged() {
            if (!network)
                return;

            if (network.connected) {
                disconnectNetworkSignals();
                passwordField.clear();
                close();
            }
        }

        function onConnectionFailed(reason) {
            if (!network)
                return;

            disconnectNetworkSignals();

            switch (reason) {
            case ConnectionFailReason.WifiNetworkLost:
                close();
                break;
            case ConnectionFailReason.NoSecrets:
                _failed = true;
                failedTimer.restart();
                break;
            default:
                _failed = true;
                failedTimer.restart();
                break;
            }
        }

        function onNetworksChanged(removed) {
            if (!network || !root.wifiDevice)
                return;

            if (removed === network)
                close();
        }

        Timer {
            id: fadeOutTimer
            interval: Config.animationFast
            repeat: false
            running: false
            onTriggered: pskDialog._renderVisible = false
        }

        Behavior on opacity {
            NumberAnimation {
                duration: Config.animationFast
            }
        }
    }
}
