import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Bluetooth

import qs.config

ItemDelegate {
    id: root

    required property BluetoothDevice modelData

    property color iconColor: Colors.textOnSurface

    property bool showBattery: false

    readonly property bool busy: modelData.state === BluetoothDeviceState.Connecting || modelData.state === BluetoothDeviceState.Disconnecting

    width: ListView.view.width

    contentItem: RowLayout {
        anchors.leftMargin: Config.spacingS
        anchors.rightMargin: Config.spacingS
        spacing: Config.spacingM

        IconText {
            text: root.getBluetoothIcon(root.modelData.icon)
            color: root.iconColor
        }

        StyledText {
            text: root.modelData.name || root.modelData.address || "Unkown"
            elide: Text.ElideRight
            Layout.fillWidth: true
            color: Colors.textOnSurface
        }

        RowLayout {
            spacing: Config.spacingXXS

            IconText {
                visible: root.showBattery && (root.modelData.batteryAvailable)
                text: root.getBatteryIcon(root.modelData.battery ?? 0)
                font.pixelSize: Config.iconSizeS
                opacity: 0.75
            }

            IconText {
                visible: root.busy
                text: "progress_activity"
                font.pixelSize: Config.iconSizeXS
                opacity: 0.75

                RotationAnimator on rotation {
                    from: 0
                    to: 360
                    duration: 1000
                    loops: Animation.Infinite
                    running: root.busy
                }
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

    function getBluetoothIcon(icon) {
        if (!icon)
            return "bluetooth";

        if (icon.includes("headset") || icon.includes("headphones"))
            return "headphones";
        if (icon.includes("audio") || icon.includes("speaker"))
            return "speaker";
        if (icon.includes("phone"))
            return "smartphone";
        if (icon.includes("mouse"))
            return "mouse";
        if (icon.includes("keyboard"))
            return "keyboard";
        if (icon.includes("printer"))
            return "print";
        if (icon.includes("camera"))
            return "photo_camera";
        if (icon.includes("watch"))
            return "watch";
        if (icon.includes("display") || icon.includes("monitor"))
            return "monitor";
        if (icon.includes("network") || icon.includes("wan"))
            return "wifi";

        return "bluetooth";
    }

    function getBatteryIcon(level) {
        if (level >= 1.0)
            return "battery_android_full";

        const step = Math.floor(level * 7);
        return `battery_android_${Math.max(0, Math.min(6, step))}`;
    }
}
