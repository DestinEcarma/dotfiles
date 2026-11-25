import QtQuick
import QtQuick.Controls

import qs.config

Switch {
    id: control
    checked: false

    indicator: Item {
        Rectangle {
            id: switchBar
            implicitWidth: 40
            implicitHeight: 24
            radius: height / 2
            color: control.checked ? Colors.secondary : Colors.surfaceContainerHigh

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.NoButton
            }

            Rectangle {
                x: control.checked ? parent.width - width - 2 : 2
                anchors.verticalCenter: parent.verticalCenter
                width: 20
                height: 20
                radius: 10
                color: control.checked ? Colors.textOnSecondary : Colors.textOnSurface

                Behavior on x {
                    NumberAnimation {
                        duration: Config.animationFast
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: Config.animationFast
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
            hovered: mouseArea.containsMouse
            anchors.fill: switchBar
            radius: switchBar.radius
        }
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 24
        radius: height / 2
        color: "transparent"
    }
}
