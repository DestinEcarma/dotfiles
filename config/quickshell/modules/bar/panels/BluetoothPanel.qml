import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Bluetooth

import qs.config
import qs.modules.components
import qs.services

Item {
    id: root

    readonly property var allDevices: Bluetooth.devices?.values ?? []
    readonly property var connectedDevices: allDevices.filter(device => device.connected)
    readonly property var pairedDevices: allDevices.filter(device => !device.connected && device.paired)
    readonly property var scannedDevices: allDevices.filter(device => !device.paired)

    readonly property bool bluetoothAvailable: Bluetooth.defaultAdapter !== null
    readonly property bool discovering: Bluetooth.defaultAdapter?.discovering ?? false

    property string _pairError: ""

    signal backRequested

    implicitWidth: 400
    implicitHeight: columnContent.implicitHeight

    Connections {
        target: FocusService.grab

        function onActiveChanged() {
            if (!FocusService.grab.active && root.discovering)
                Bluetooth.defaultAdapter.discovering = false;
        }
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
                    if (root.discovering)
                        Bluetooth.defaultAdapter.discovering = false;
                    root.backRequested();
                }
            }

            StyledText {
                text: "Bluetooth"
                font.bold: true
                font.pixelSize: Config.fontSizeL
                Layout.fillWidth: true
            }

            ToggleSwitch {
                visible: root.bluetoothAvailable
                padding: 0
                checked: Bluetooth.defaultAdapter?.enabled ?? false
                onToggled: {
                    if (Bluetooth.defaultAdapter)
                        Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
                }
            }
        }

        StyledText {
            visible: !root.bluetoothAvailable
            text: "No Bluetooth adapter found"
            font.pixelSize: Config.fontSizeS
            opacity: 0.75
            Layout.alignment: Qt.AlignHCenter
        }

        ColumnLayout {
            visible: root.bluetoothAvailable && Bluetooth.defaultAdapter.enabled
            spacing: Config.spacingM

            ColumnLayout {
                visible: root.connectedDevices.length > 0
                spacing: Config.spacingM

                StyledText {
                    text: "Connected devices"
                    font.pixelSize: Config.fontSizeS
                    opacity: 0.75
                }

                ListView {
                    Layout.fillWidth: true
                    implicitHeight: Math.min(contentHeight, 131)
                    spacing: Config.spacingXS
                    model: root.connectedDevices
                    clip: true

                    delegate: BluetoothListItem {
                        showBattery: true
                        iconColor: Colors.primary
                        onClicked: modelData.disconnect()
                    }
                }
            }

            ColumnLayout {
                visible: root.pairedDevices.length > 0
                spacing: Config.spacingM

                StyledText {
                    text: "Paired devices"
                    font.pixelSize: Config.fontSizeS
                    opacity: 0.75
                }

                ListView {
                    Layout.fillWidth: true
                    implicitHeight: Math.min(contentHeight, 131)
                    spacing: Config.spacingXS
                    model: root.pairedDevices
                    clip: true

                    delegate: BluetoothListItem {
                        onClicked: modelData.connect()
                    }
                }
            }

            RowLayout {
                StyledText {
                    text: root.discovering ? "Scanning" : "Scan for devices"
                    font.pixelSize: Config.fontSizeS
                    opacity: 0.75
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    IconText {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 1
                        visible: root.discovering

                        text: "progress_activity"
                        font.pixelSize: Config.iconSizeXS
                        opacity: 0.75

                        RotationAnimator on rotation {
                            from: 0
                            to: 360
                            duration: 1000
                            loops: Animation.Infinite
                            running: root.discovering
                        }
                    }
                }

                IconButton {
                    implicitWidth: 24
                    implicitHeight: 24
                    icon: root.discovering ? "sensors_off" : "sensors"
                    iconText.font.pixelSize: Config.iconSizeS
                    onActivated: {
                        if (Bluetooth.defaultAdapter)
                            Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering;
                    }
                }
            }

            StyledText {
                visible: root.discovering && root.scannedDevices.length === 0
                text: "No devices found yet…"
                font.pixelSize: Config.fontSizeS
                opacity: 0.5
            }

            StyledText {
                visible: root._pairError !== ""
                text: root._pairError
                font.pixelSize: Config.fontSizeS
                opacity: 0.75
                color: Colors.error

                Timer {
                    interval: 5000
                    running: root._pairError !== ""
                    onTriggered: root._pairError = ""
                }
            }

            ListView {
                visible: root.discovering || root.scannedDevices.length > 0
                Layout.fillWidth: true
                implicitHeight: Math.min(contentHeight, 131)
                spacing: Config.spacingXS
                model: root.scannedDevices
                clip: true

                delegate: BluetoothListItem {
                    onClicked: {
                        if (modelData.pairing || busy)
                            return;

                        modelData.pair();
                    }
                }
            }
        }
    }
}
