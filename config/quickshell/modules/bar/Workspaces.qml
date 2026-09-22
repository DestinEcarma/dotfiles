import QtQuick
import QtQuick.Layouts

import Quickshell.Hyprland

import qs.config
import qs.modules.components

Item {
    id: root

    property var workspaceIds: {
        let ids = [];

        for (const ws of Hyprland.workspaces.values) {
            if (ws.id > 0 && ws.toplevels.values.length > 0 || ws.focused)
                ids.push(ws.id);
        }

        return ids;
    }

    implicitWidth: workspaces.implicitWidth
    implicitHeight: workspaces.implicitHeight

    Rectangle {
        id: workspaces

        readonly property int rawWidth: contentRow.implicitWidth + Config.spacingXS * 2

        implicitWidth: rawWidth
        implicitHeight: 30
        radius: height / 2
        color: Colors.background
        clip: true

        Item {
            implicitHeight: parent.height
            implicitWidth: parent.rawWidth

            RowLayout {
                id: contentRow
                anchors.fill: parent
                anchors.margins: Config.spacingXS
                spacing: Config.spacingS

                Repeater {
                    model: root.workspaceIds

                    delegate: Rectangle {
                        id: wsDot

                        required property int modelData
                        readonly property HyprlandWorkspace hyprWs: Hyprland.workspaces.values.find(ws => ws.id === modelData) ?? null
                        readonly property bool isActive: hyprWs !== null && hyprWs.focused

                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        radius: height / 2

                        color: {
                            if (mouseArea.containsMouse && !wsDot.isActive)
                                return Colors.primaryContainer;
                            return isActive ? Colors.primary : Colors.surfaceContainerHighest;
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (wsDot.hyprWs !== null)
                                    wsDot.hyprWs.activate();
                                else
                                    Hyprland.dispatch(`workspace ${wsDot.modelData}`);
                            }
                        }

                        StyledText {
                            opacity: wsDot.isActive || mouseArea.containsMouse ? 1 : 0
                            anchors.centerIn: parent
                            text: wsDot.hyprWs?.name ?? wsDot.modelData.toString()
                            font.bold: true
                            color: {
                                if (mouseArea.containsMouse)
                                    return wsDot.isActive ? Colors.textOnPrimary : Colors.textOnPrimaryContainer;
                                else
                                    Colors.textOnPrimary;
                            }

                            Behavior on opacity {
                                NumberAnimation {
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
                }
            }
        }

        Behavior on implicitWidth {
            NumberAnimation {
                duration: Config.animationNormal
                easing.type: Config.easingStandard
            }
        }
    }

    Shadow {
        anchors.fill: workspaces
        radius: workspaces.radius
    }
}
