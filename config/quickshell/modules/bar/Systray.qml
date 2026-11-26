import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray

import qs.config
import qs.components
import qs.services

Item {
    id: root

    readonly property bool hasTrayItems: SystemTray.items.values.length > 0
    property SystemTrayItem selectedTrayItem: null

    Connections {
        target: FocusService.grab

        function onActiveChanged() {
            if (!FocusService.grab.active)
                root.selectedTrayItem = null;
        }
    }

    implicitWidth: trayLoader.implicitWidth
    implicitHeight: trayLoader.implicitHeight

    Loader {
        id: trayLoader

        active: root.hasTrayItems
        asynchronous: true

        sourceComponent: Component {
            Item {
                implicitWidth: tray.implicitWidth
                implicitHeight: tray.implicitHeight

                Rectangle {
                    id: tray

                    readonly property int rawWidth: Math.max(Math[root.selectedTrayItem ? "max" : "min"](contentRow.implicitWidth, trayMenu.implicitWidth) + Config.spacingXS * 2, 30)

                    implicitWidth: rawWidth
                    implicitHeight: root.selectedTrayItem ? 30 + trayMenu.implicitHeight : 30
                    radius: 15
                    color: Colors.background
                    clip: true

                    Item {
                        implicitWidth: contentRow.implicitWidth
                        implicitHeight: 30

                        RowLayout {
                            id: contentRow

                            anchors.fill: parent
                            anchors.margins: Config.spacingXS
                            spacing: Config.spacingS

                            Repeater {
                                model: SystemTray.items

                                delegate: Item {
                                    id: trayItem

                                    required property SystemTrayItem modelData

                                    Layout.fillHeight: true
                                    Layout.preferredWidth: height

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        acceptedButtons: Qt.LeftButton | Qt.RightButton

                                        onClicked: event => {
                                            if (event.button === Qt.LeftButton)
                                                trayItem.modelData.activate();
                                            else if (trayItem.modelData.hasMenu) {
                                                FocusService.requestFocus();
                                                root.selectedTrayItem = trayItem.modelData;
                                            } else
                                                trayItem.modelData.secondaryActivate();
                                        }
                                    }

                                    Image {
                                        anchors.fill: parent
                                        source: trayItem.modelData.icon
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        id: trayMenu
                        implicitWidth: 240

                        implicitHeight: menuColumn.implicitHeight + Config.spacingS

                        visible: root.selectedTrayItem !== null && root.selectedTrayItem.hasMenu

                        QsMenuOpener {
                            id: menuOpener
                            menu: root.selectedTrayItem?.menu ?? null
                        }

                        ColumnLayout {
                            id: menuColumn
                            anchors.margins: Config.spacingS
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.topMargin: 30

                            Repeater {
                                model: menuOpener.children
                                delegate: ItemDelegate {
                                    id: menuItem

                                    required property QsMenuEntry modelData

                                    Layout.fillWidth: true
                                    Layout.preferredHeight: modelData.isSeparator ? 1 : Config.fontSizeS + Config.spacingS

                                    enabled: modelData.enabled

                                    background: Rectangle {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        radius: Config.radiusXS
                                        color: menuItem.modelData.isSeparator ? Colors.primary : menuItem.hovered ? Colors.surfaceContainerHighest : "transparent"
                                    }

                                    contentItem: RowLayout {
                                        anchors.fill: parent
                                        spacing: Config.spacingS
                                        anchors.leftMargin: Config.spacingS
                                        anchors.rightMargin: Config.spacingS

                                        Image {
                                            Layout.preferredWidth: 20
                                            Layout.preferredHeight: 20
                                            source: menuItem.modelData.icon
                                            visible: menuItem.modelData.icon !== ""
                                        }

                                        StyledText {
                                            id: text
                                            Layout.fillWidth: true
                                            text: menuItem.modelData.text
                                            font.pixelSize: Config.fontSizeS
                                            color: menuItem.enabled ? Colors.textOnBackground : Colors.textOnSurfaceVariant
                                            elide: Text.ElideRight
                                        }
                                    }

                                    onClicked: {
                                        FocusService.releaseFocus();
                                        menuItem.modelData.triggered();
                                    }
                                }
                            }
                        }
                    }

                    Behavior on implicitWidth {
                        enabled: !Config.gaming
                        NumberAnimation {
                            duration: Config.animationNormal
                            easing.type: Config.easingStandard
                        }
                    }

                    Behavior on implicitHeight {
                        enabled: !Config.gaming
                        NumberAnimation {
                            duration: Config.animationNormal
                            easing.type: Config.easingStandard
                        }
                    }
                }

                Shadow {
                    anchors.fill: tray
                    radius: tray.radius
                }
            }
        }
    }
}
