import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs.config
import qs.services

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 500

    exclusiveZone: 40
    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    mask: Region {
        item: island

        Region {
            item: workspaces
        }

        Region {
            item: systray
        }

        Region {
            item: powerButton
        }
    }

    RowLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: Config.barMargin

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                spacing: Config.spacingL
                anchors.left: parent.left

                Workspaces {
                    id: workspaces
                }

                Systray {
                    id: systray
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Config.spacingL

                IslandBackground {
                    id: island
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                spacing: Config.spacingL
                anchors.right: parent.right

                PowerButton {
                    id: powerButton
                }
            }
        }
    }

    Component.onCompleted: {
        FocusService.grab = grab;
    }

    HyprlandFocusGrab {
        id: grab
        windows: [root]
    }
}
