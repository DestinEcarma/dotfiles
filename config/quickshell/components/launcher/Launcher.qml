import QtQuick.Controls
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Hyprland

import "Calculator.js" as Calculator

PanelWindow {
    id: root

    visible: false
    implicitWidth: 620
    implicitHeight: card.implicitHeight + 24
    color: "transparent"

    anchors.top: true
    margins.top: 130
    exclusionMode: ExclusionMode.Ignore

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    readonly property string query: search.text.trim().toLowerCase()
    readonly property string result: Calculator.evaluate(search.text)
    readonly property bool calculatorMode: result !== "" || query.startsWith("=")

    readonly property var matches: {
        if (calculatorMode)
            return [];

        const q = query;
        const apps = Array.from(DesktopEntries.applications.values);

        return apps.filter(app => app.name.toLowerCase().includes(q)).sort((a, b) => {
            const aName = a.name.toLowerCase();
            const bName = b.name.toLowerCase();
            return Number(bName.startsWith(q)) - Number(aName.startsWith(q)) || a.name.localeCompare(b.name);
        }).slice(0, 40);
    }

    function openLauncher() {
        const monitor = Hyprland.focusedMonitor;
        const target = Quickshell.screens.find(screen => Hyprland.monitorFor(screen) === monitor);

        if (target)
            root.screen = target;

        search.clear();
        root.visible = true;
        Qt.callLater(() => search.forceActiveFocus());
    }

    function launch(entry) {
        if (!entry)
            return;

        root.visible = false;
        entry.execute();
    }

    IpcHandler {
        target: "spotlight"

        function toggle(): void {
            if (root.visible)
                root.visible = false;
            else
                root.openLauncher();
        }
    }

    Rectangle {
        id: card

        anchors.fill: parent
        anchors.margins: 12
        implicitHeight: content.implicitHeight + 24

        radius: 20
        color: "#f2212228" border.color: "#555762"

        ColumnLayout {
            id: content

            x: 12
            y: 12
            width: parent.width - 24
            spacing: 8

            TextField {
                id: search

                Layout.fillWidth: true
                Layout.preferredHeight: 54
                leftPadding: 16
                rightPadding: 16

                placeholderText: "Search apps or calculate…"
                placeholderTextColor: "#a7a8b3"
                color: "#ffffff"
                selectionColor: "#526694"
                font.pixelSize: 22
                selectByMouse: true

                background: Rectangle {
                    radius: 12
                    color: "#30313a"
                }

                onTextChanged: results.currentIndex = 0

                Keys.onEscapePressed: root.visible = false

                Keys.onDownPressed: {
                    if (results.count > 0)
                        results.currentIndex = Math.min(results.currentIndex + 1, results.count - 1);
                }

                Keys.onUpPressed: {
                    if (results.count > 0)
                        results.currentIndex = Math.max(results.currentIndex - 1, 0);
                }

                onAccepted: {
                    if (root.result !== "") {
                        // Keep the answer in the field so you can reuse it.
                        search.text = "=" + root.result;
                        search.cursorPosition = search.length;
                    } else if (!root.calculatorMode) {
                        root.launch(root.matches[results.currentIndex]);
                    }
                }
            }

            Label {
                Layout.fillWidth: true
                Layout.leftMargin: 16
                Layout.bottomMargin: visible ? 8 : 0
                visible: root.calculatorMode || root.matches.length === 0

                text: root.result !== "" ? "= " + root.result : root.calculatorMode ? "Enter a valid expression" : "No matching apps"

                color: root.result !== "" ? "#b9ccff" : "#a7a8b3"
                font.pixelSize: root.result !== "" ? 26 : 15
                elide: Text.ElideRight
            }

            ListView {
                id: results

                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(count, 6) * 46
                visible: count > 0
                clip: true
                model: root.matches
                currentIndex: 0
                keyNavigationEnabled: false

                onCurrentIndexChanged: {
                    if (currentIndex >= 0)
                        positionViewAtIndex(currentIndex, ListView.Contain);
                }

                delegate: ItemDelegate {
                    id: row

                    required property var modelData

                    width: ListView.view.width
                    height: 46
                    hoverEnabled: true
                    focusPolicy: Qt.NoFocus
                    highlighted: ListView.isCurrentItem

                    onClicked: root.launch(modelData)

                    background: Rectangle {
                        radius: 10
                        color: row.highlighted ? "#40537a" : row.hovered ? "#343641" : "transparent"
                    }

                    contentItem: RowLayout {
                        spacing: 12

                        IconImage {
                            Layout.preferredWidth: 26
                            Layout.preferredHeight: 26
                            source: Quickshell.iconPath(row.modelData.icon, true)
                        }

                        Label {
                            Layout.fillWidth: true
                            text: row.modelData.name
                            color: "#ffffff"
                            font.pixelSize: 16
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }
}
