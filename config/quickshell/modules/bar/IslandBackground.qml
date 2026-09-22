import QtQuick

import Quickshell

import qs.config
import qs.modules.components
import qs.services

Item {
    id: root

    property bool expanded: FocusService.grab?.active ?? false

    readonly property int collapsedWidth: 120
    readonly property int collapsedHeight: 30

    implicitWidth: island.implicitWidth
    implicitHeight: island.implicitHeight

    Rectangle {
        id: island
        implicitWidth: root.expanded ? expandedContent.implicitWidth + Config.spacingL * 2 : root.collapsedWidth
        implicitHeight: root.expanded ? expandedContent.implicitHeight + Config.spacingL * 2 : root.collapsedHeight
        radius: root.expanded ? Config.radiusL : height / 2

        clip: true

        color: Colors.background

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: root.expanded ? Qt.ArrowCursor : Qt.PointingHandCursor
            onClicked: {
                if (expandedContent.active === false)
                    expandedContent.active = true;

                if (FocusService.grab && !FocusService.grab.active)
                    FocusService.requestFocus();
            }
        }

        CollapsedContent {
            anchors.centerIn: parent
            visible: !root.expanded
            opacity: root.expanded ? 0 : 1

            Behavior on opacity {
                NumberAnimation {
                    duration: Config.animationNormal
                }
            }
        }

        ExpandedContent {
            id: expandedContent
            active: false
            anchors.fill: parent
            anchors.margins: Config.spacingL
            visible: root.expanded
            opacity: root.expanded ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: Config.animationNormal
                }
            }
        }

        Behavior on implicitWidth {
            NumberAnimation {
                duration: Config.animationNormal
                easing.type: Config.easingStandard
            }
        }
        Behavior on implicitHeight {
            NumberAnimation {
                duration: Config.animationNormal
                easing.type: Config.easingStandard
            }
        }
        Behavior on radius {
            NumberAnimation {
                duration: Config.animationNormal
            }
        }
    }

    Shadow {
        anchors.fill: island
        radius: island.radius
    }
}
