import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Networking

import qs.config

ItemDelegate {
    id: root

    required property WifiNetwork modelData

    width: ListView.view.width

    contentItem: RowLayout {
        anchors.leftMargin: Config.spacingS
        anchors.rightMargin: Config.spacingS
        spacing: Config.spacingM

        IconText {
            IconText {
                id: signalLayer
                z: -1
                anchors.fill: parent
                text: "wifi"
                color: Colors.textOnSurfaceVariant
                opacity: 0.25
            }

            text: {
                if (!root.modelData) {
                    signalLayer.visible = false;
                    return "wifi_off";
                }

                const strength = root.modelData.signalStrength;

                if (strength >= 0.66) {
                    signalLayer.visible = false;
                    return "wifi";
                }

                signalLayer.visible = true;

                if (strength >= 0.33)
                    return "wifi_2_bar";

                return "wifi_1_bar";
            }

            color: root.modelData.connected ? Colors.primary : Colors.textOnSurfaceVariant
        }

        StyledText {
            text: root.modelData.name || "Unknown"
            elide: Text.ElideRight
            Layout.fillWidth: true
            color: Colors.textOnSurface
        }

        RowLayout {
            spacing: Config.spacingXXS

            IconText {
                text: "progress_activity"
                visible: root.modelData.stateChanging
                font.pixelSize: Config.iconSizeXS
                opacity: 0.75

                RotationAnimator on rotation {
                    from: 0
                    to: 360
                    duration: 1000
                    loops: Animation.Infinite
                    running: root.modelData.stateChanging ?? false
                }
            }

            IconText {
                visible: root.requireSecret(root.modelData.security)
                text: "lock"
                font.pixelSize: Config.iconSizeXS
            }
        }
    }

    background: Rectangle {
        radius: Config.radiusM
        color: cardMouseArea.containsMouse ? Colors.surfaceContainer : Colors.surfaceContainerLow

        MouseArea {
            id: cardMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.NoButton
        }

        Behavior on color {
            ColorAnimation {
                duration: Config.animationFast
            }
        }
    }

    function requireSecret(security) {
        return security === WifiSecurityType.WpaPsk || security === WifiSecurityType.Wpa2Psk || security === WifiSecurityType.Sae;
    }
}
