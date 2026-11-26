import QtQuick
import QtQuick.Controls

import Quickshell

import qs.components
import qs.config

Rectangle {
    id: root

    required property DesktopEntry modelData
    required property bool selected

    signal clicked
    signal hovered

    height: 62
    radius: Config.radiusM

    color: selected ? Colors.primaryContainer : mouseArea.containsMouse ? Colors.surfaceContainerHigh : "transparent"

    Behavior on color {
        enabled: !Config.gaming
        ColorAnimation {
            duration: Config.animationNormal
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: root.clicked()
        onEntered: root.hovered()
    }

    Row {
        anchors.fill: parent
        anchors.leftMargin: Config.spacingM
        anchors.rightMargin: Config.spacingM
        spacing: Config.spacingM

        Rectangle {
            width: 38
            height: 38
            radius: Config.radiusS
            color: selected ? Colors.textOnPrimaryContainer : Colors.surfaceContainerHighest

            anchors.verticalCenter: parent.verticalCenter

            Image {
                anchors.centerIn: parent
                width: 26
                height: 26
                source: Quickshell.iconPath(root.modelData.icon ?? "", "image-missing")
                sourceSize.width: 52
                sourceSize.height: 52
                fillMode: Image.PreserveAspectFit
            }

            Behavior on color {
                enabled: !Config.gaming
                ColorAnimation {
                    duration: Config.animationNormal
                }
            }
        }

        Column {
            width: parent.width - 38 - parent.spacing
            anchors.verticalCenter: parent.verticalCenter
            spacing: Config.spacingXXS

            StyledText {
                width: parent.width
                text: root.modelData.name ?? ""
                font.pixelSize: Config.fontSizeM
                color: selected ? Colors.textOnPrimaryContainer : Colors.textOnSurface
                elide: Text.ElideRight

                Behavior on color {
                    enabled: !Config.gaming
                    ColorAnimation {
                        duration: Config.animationNormal
                    }
                }
            }

            StyledText {
                width: parent.width
                text: root.modelData.comment ?? root.modelData.genericName ?? ""
                font.pixelSize: Config.fontSizeS
                color: selected ? Colors.textOnPrimaryContainer : Colors.textOnSurfaceVariant
                elide: Text.ElideRight
            }
        }
    }
}
