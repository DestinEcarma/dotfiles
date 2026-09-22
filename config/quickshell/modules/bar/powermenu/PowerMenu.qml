import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.config
import qs.modules.bar.powermenu
import qs.services

PanelWindow {
    id: root

    signal closeRequested

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: "#A0000000"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    function close() {
        root.closeRequested();
    }

    BackgroundEffect.blurRegion: Region {
        item: root.contentItem
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.close()
    }

    Rectangle {
        id: card
        anchors.centerIn: parent
        implicitWidth: grid.implicitWidth + Config.spacingL * 2
        implicitHeight: grid.implicitHeight + Config.spacingL * 2
        radius: Config.radiusL
        color: Colors.surfaceContainerLowest

        focus: true
        Keys.onEscapePressed: root.close()

        MouseArea {
            anchors.fill: parent
        }

        GridLayout {
            id: grid
            anchors.centerIn: parent
            columns: 3
            rowSpacing: Config.spacingL
            columnSpacing: Config.spacingL

            PowerButtonItemList {
                label: "Lock"
                icon: "lock"
                onActivated: {
                    SessionService.lock();
                    root.close();
                }
            }
            PowerButtonItemList {
                label: "Logout"
                icon: "logout"
                onActivated: {
                    SessionService.logout();
                    root.close();
                }
            }
            PowerButtonItemList {
                label: "Suspend"
                icon: "pause_circle"
                onActivated: {
                    SessionService.suspend();
                    root.close();
                }
            }
            PowerButtonItemList {
                label: "Hibernate"
                icon: "bedtime"
                onActivated: {
                    SessionService.hibernate();
                    root.close();
                }
            }
            PowerButtonItemList {
                label: "Reboot"
                icon: "refresh"
                onActivated: {
                    SessionService.reboot();
                    root.close();
                }
            }
            PowerButtonItemList {
                label: "Shutdown"
                icon: "power_settings_new"
                primary: "#f38ba8"
                onActivated: {
                    SessionService.shutdown();
                    root.close();
                }
            }
        }
    }

    Component.onCompleted: grab.active = true

    HyprlandFocusGrab {
        id: grab
        windows: [root]
        onActiveChanged: {
            if (!active)
                root.close();
        }
    }
}
