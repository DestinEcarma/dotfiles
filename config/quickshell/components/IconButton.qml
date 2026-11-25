import QtQuick

import qs.config

Item {
    id: root

    property string icon: ""
    property bool disabled: false
    property alias hovered: iconButtonMouseArea.containsMouse

    property int nudgeX: 0
    property int nudgeY: 1

    property color color: Colors.surfaceContainerLow
    property color hoveredColor: Colors.surfaceContainer

    property IconText iconText: _iconText

    signal activated

    implicitWidth: 36
    implicitHeight: 36

    Rectangle {
        id: iconButton
        anchors.fill: parent
        radius: height / 2
        color: {
            if (root.disabled)
                return Colors.surfaceContainerLowest;
            return iconButtonMouseArea.containsMouse ? root.hoveredColor : root.color;
        }

        MouseArea {
            id: iconButtonMouseArea
            enabled: !root.disabled
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: !root.disabled && Qt.PointingHandCursor
            onClicked: root.activated()
        }

        IconText {
            id: _iconText
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: root.nudgeX
            anchors.verticalCenterOffset: root.nudgeY
            text: root.icon
            color: root.disabled ? Colors.textOnSurfaceVariant : Colors.textOnSurface
        }

        Behavior on color {
            ColorAnimation {
                duration: Config.animationFast
            }
        }
    }

    HoverShadow {
        hovered: iconButtonMouseArea.containsMouse
        anchors.fill: iconButton
        radius: iconButton.radius
    }
}
