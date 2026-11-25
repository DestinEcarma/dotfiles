import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.config

Slider {
    id: root

    Layout.fillWidth: true

    from: 0
    to: 100

    background: Item {
        implicitHeight: 24

        Rectangle {
            id: sliderBar
            x: root.leftPadding
            y: root.topPadding + root.availableHeight / 2 - height / 2
            width: root.availableWidth
            height: parent.implicitHeight
            radius: height / 2
            color: sliderMouseArea.containsMouse ? Colors.surfaceContainerLowest : Colors.surfaceContainerLowest

            MouseArea {
                id: sliderMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }

            Rectangle {
                width: Math.max(parent.radius * 2, root.visualPosition * (parent.width - handle.width) + handle.width)
                height: parent.height
                radius: parent.radius
                color: Colors.secondary
            }

            Behavior on color {
                ColorAnimation {
                    duration: Config.animationFast
                }
            }
        }

        HoverShadow {
            hovered: sliderMouseArea.containsMouse
            anchors.fill: sliderBar
            radius: sliderBar.radius
        }
    }

    handle: Rectangle {
        id: handle
        width: root.height
        height: root.height
        opacity: 0
    }
}
