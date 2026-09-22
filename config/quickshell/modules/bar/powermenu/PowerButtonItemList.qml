import QtQuick
import QtQuick.Layouts

import qs.config
import qs.modules.components

ColumnLayout {
    id: root

    property string label: ""
    property string icon: ""
    property color primary: Colors.primary
    signal activated

    spacing: Config.spacingS

    Rectangle {
        Layout.preferredWidth: 150
        Layout.preferredHeight: 150
        radius: Config.radiusL
        color: mouseArea.containsMouse ? Colors.surfaceContainerHighest : Colors.surfaceContainer

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.activated()
        }

        IconText {
            anchors.centerIn: parent
            text: root.icon
            font.pixelSize: Config.iconSizeXXXL
            color: Colors.textOnSurface
        }

        Behavior on color {
            ColorAnimation {
                duration: Config.animationFast
            }
        }
    }

    StyledText {
        Layout.alignment: Qt.AlignHCenter
        text: root.label
        font.pixelSize: Config.fontSizeS
        color: Colors.textOnSurface
        opacity: 0.75
    }
}
