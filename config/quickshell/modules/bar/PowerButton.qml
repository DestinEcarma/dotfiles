import QtQuick

import Quickshell

import qs.config
import qs.modules.bar.powermenu
import qs.modules.components

Item {
    id: root

    implicitWidth: 30
    implicitHeight: 30

    property bool menuOpen: false

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: powerMenuLoader.active = true
    }

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: mouseArea.containsMouse ? Colors.surfaceContainerHighest : Colors.background

        Behavior on color {
            ColorAnimation {
                duration: Config.animationFast
            }
        }
    }

    IconText {
        id: icon
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 1
        text: "power_settings_new"
        font.pixelSize: Config.fontSizeL
        font.bold: true
        color: Colors.textOnSurface

        Behavior on color {
            ColorAnimation {
                duration: Config.animationFast
            }
        }
    }

    Shadow {
        anchors.fill: parent
        radius: height / 2
    }

    LazyLoader {
        id: powerMenuLoader
        PowerMenu {
            onCloseRequested: powerMenuLoader.active = false
        }
    }
}
