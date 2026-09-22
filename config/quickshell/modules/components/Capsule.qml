import QtQuick
import QtQuick.Layouts

import qs.config

Item {
    id: root

    property string icon: ""
    property string label: ""
    property string caption: ""
    property bool captionEnabled: false

    property bool iconToggled: true
    property bool iconInteractive: true

    signal activated
    signal iconActivated

    Layout.fillWidth: true

    implicitHeight: 60

    Rectangle {
        id: capsule

        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: Config.radiusM

        color: capsuleMouseArea.containsMouse ? Colors.surfaceContainer : Colors.surfaceContainerLow

        MouseArea {
            id: capsuleMouseArea
            anchors.fill: capsule
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.activated()
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: Config.spacingS
            spacing: Config.spacingM

            Item {
                Layout.fillHeight: true
                Layout.preferredWidth: height

                Rectangle {
                    id: iconButton

                    anchors.fill: parent
                    radius: height / 2

                    color: {
                        if (root.iconToggled)
                            return Colors.secondary;
                        if (iconButtonMouseArea.containsMouse || capsuleMouseArea.containsMouse)
                            return Colors.surfaceContainerHighest;
                        return Colors.surfaceContainerHigh;
                    }

                    MouseArea {
                        id: iconButtonMouseArea
                        enabled: root.iconInteractive
                        anchors.fill: iconButton
                        hoverEnabled: root.iconInteractive
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.iconActivated()
                    }

                    IconText {
                        anchors.centerIn: parent
                        text: root.icon
                        color: root.iconToggled ? Colors.textOnSecondary : Colors.textOnSurface
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

            ColumnLayout {
                spacing: -1

                StyledText {
                    text: root.label
                    font.bold: true
                    color: Colors.textOnSurface
                    Layout.fillWidth: true
                }

                StyledText {
                    visible: root.captionEnabled
                    text: root.caption
                    font.pixelSize: Config.fontSizeS
                    opacity: 0.75
                    color: Colors.textOnSurface
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                }
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: Config.animationFast
            }
        }
    }

    HoverShadow {
        hovered: capsuleMouseArea.containsMouse
        anchors.fill: capsule
        radius: capsule.radius
    }
}
