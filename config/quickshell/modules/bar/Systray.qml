import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Services.SystemTray

import qs.config
import qs.modules.components

Item {
    id: root

    readonly property bool hasTrayItems: SystemTray.items.values.length > 0

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

                    readonly property int rawWidth: contentRow.implicitWidth + Config.spacingXS * 2

                    implicitWidth: rawWidth
                    implicitHeight: 30

                    radius: height / 2
                    color: Colors.background
                    clip: true

                    Item {
                        implicitWidth: tray.rawWidth
                        implicitHeight: tray.height

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
                                            else
                                                trayItem.modelData.secondaryActivate();
                                        }
                                    }

                                    Image {
                                        anchors.centerIn: parent
                                        width: parent.width
                                        height: parent.height
                                        source: trayItem.modelData.icon
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
                    anchors.fill: tray
                    radius: tray.radius
                }
            }
        }
    }
}
