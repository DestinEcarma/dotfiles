import QtQuick
import QtQuick.Controls

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland

import qs.components
import qs.config

PanelWindow {
    id: root

    visible: false
    color: "transparent"
    screen: Quickshell.screens[0]

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "quickshell:launcher"

    property string query: ""
    property bool calculatorMode: false
    property string calculatorResult: ""
    property var results: DesktopEntries.applications.values ?? []
    property int selectedIndex: 0

    function open() {
        root.visible = true;
        search.text = "";
        root.query = "";
        root.calculatorResult = "";
        root.selectedIndex = 0;
        search.forceActiveFocus();
    }

    function close() {
        root.visible = false;
    }

    function toggle() {
        root.visible ? root.close() : root.open();
    }

    function isMath(text) {
        const clean = text.trim();

        if (clean.length === 0)
            return false;

        const validCharacters = /^[0-9+\-*/().%^ ]+$/.test(clean);
        const hasOperator = /[+\-*/^]/.test(clean);
        const hasNumber = /[0-9]/.test(clean);

        return validCharacters && hasOperator && hasNumber;
    }

    function updateResults() {
        const q = search.text.trim().toLowerCase();
        root.query = q;
        root.calculatorMode = root.isMath(q);
        root.selectedIndex = 0;

        if (root.calculatorMode) {
            root.results = [];
            calcTimer.restart();
            return;
        }

        calcTimer.stop();

        const apps = DesktopEntries.applications.values ?? [];
        const filtered = [];

        for (let i = 0; i < apps.length; i++) {
            const app = apps[i];
            const name = (app.name ?? "").toLowerCase();
            const genericName = (app.genericName ?? "").toLowerCase();
            const comment = (app.comment ?? "").toLowerCase();

            if (q === "" || name.includes(q) || genericName.includes(q) || comment.includes(q)) {
                filtered.push(app);
            }

            if (filtered.length >= 40)
                break;
        }

        root.results = filtered;
    }

    function calculate() {
        const expression = search.text.trim();

        if (!root.isMath(expression)) {
            root.calculatorResult = "";
            return;
        }

        const safeExpression = expression.replace(/[^0-9+\-*/().%^ ]/g, "");

        calculatorProcess.command = ["sh", "-c", "printf '%s\\n' \"$1\" | bc -l", "sh", safeExpression];
        calculatorProcess.running = true;
    }

    function copyResult() {
        if (!root.calculatorMode || root.calculatorResult === "")
            return;

        Quickshell.execDetached(["wl-copy", root.calculatorResult]);
    }

    function activateSelected() {
        if (root.calculatorMode) {
            root.copyResult();
            return;
        }

        const app = root.results[root.selectedIndex];

        if (app) {
            app.execute();
            root.close();
        }
    }

    function selectNext() {
        if (root.calculatorMode || root.results.length === 0)
            return;

        if (root.selectedIndex < root.results.length - 1)
            root.selectedIndex++;

        resultList.positionViewAtIndex(root.selectedIndex, ListView.Visible);
    }

    function selectPrevious() {
        if (root.calculatorMode || root.results.length === 0)
            return;

        if (root.selectedIndex > 0)
            root.selectedIndex--;

        resultList.positionViewAtIndex(root.selectedIndex, ListView.Visible);
    }

    Process {
        id: calculatorProcess

        stdout: StdioCollector {
            onStreamFinished: root.calculatorResult = text.trim()
        }
    }

    Timer {
        id: calcTimer
        interval: 180
        onTriggered: root.calculate()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.close()
    }

    Rectangle {
        id: launcherCard

        width: 680
        height: Math.min(520, root.height - Config.spacingXXL * 2)
        radius: Config.radiusL
        color: Colors.background

        anchors.centerIn: parent

        Column {
            anchors.fill: parent
            anchors.margins: Config.spacingM
            spacing: Config.spacingS

            Rectangle {
                width: parent.width
                height: Config.iconSizeM + Config.spacingM * 2
                radius: Config.radiusM
                color: Colors.surfaceContainerHigh

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: Config.spacingM
                    anchors.rightMargin: Config.spacingM
                    spacing: Config.spacingS

                    IconText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: root.calculatorMode ? "calculate" : "search"
                        color: root.calculatorMode ? Colors.tertiary : Colors.textOnSurfaceVariant
                    }

                    StyledTextField {
                        id: search

                        width: parent.width - parent.spacing - Config.iconSizeM
                        anchors.verticalCenter: parent.verticalCenter

                        placeholderText: "Search..."
                        font.pixelSize: Config.fontSizeL
                        color: Colors.textOnSurface

                        onTextChanged: root.updateResults()
                        onAccepted: {
                            if (root.calculatorMode && root.calculatorResult) {
                                root.copyResult();
                                return;
                            }

                            root.activateSelected();
                        }

                        Keys.onEscapePressed: root.close()
                        Keys.onUpPressed: root.selectPrevious()
                        Keys.onDownPressed: root.selectNext()
                        Keys.onPressed: event => {
                            if (event.modifiers & Qt.ControlModifier) {
                                if (event.key === Qt.Key_N) {
                                    root.selectNext();
                                    event.accepted = true;
                                } else if (event.key === Qt.Key_P) {
                                    root.selectPrevious();
                                    event.accepted = true;
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                visible: root.calculatorMode && root.calculatorResult
                width: parent.width
                height: Config.iconSizeS + Config.spacingM * 2
                radius: Config.radiusM
                color: Colors.tertiaryContainer

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: Config.spacingM
                    anchors.rightMargin: Config.spacingM
                    spacing: Config.spacingS

                    IconButton {
                        anchors.verticalCenter: parent.verticalCenter
                        implicitWidth: 28
                        implicitHeight: 28
                        icon: "content_copy"
                        iconText.color: root.calculatorMode ? Colors.tertiary : Colors.textOnSurfaceVariant
                        iconText.font.pixelSize: Config.iconSizeS
                        color: Colors.tertiaryContainer
                        hoveredColor: Colors.primaryContainer
                        onActivated: root.copyResult()
                    }

                    StyledText {
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        text: `= ${root.calculatorResult}`
                        font.pixelSize: Config.fontSizeL
                        font.bold: true
                        color: Colors.textOnTertiaryContainer
                        elide: Text.ElideRight
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.copyResult()
                }
            }

            // App results
            ListView {
                id: resultList

                visible: !root.calculatorMode
                width: parent.width
                height: parent.height - (Config.iconSizeM + Config.spacingM * 2) - Config.spacingS
                clip: true
                spacing: Config.spacingXXS
                model: root.results

                delegate: AppResult {
                    required property int index

                    width: resultList.width
                    selected: index === root.selectedIndex

                    onClicked: {
                        root.selectedIndex = index;
                        root.activateSelected();
                    }

                    onHovered: root.selectedIndex = index
                }

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                }
            }
        }
    }

    Shadow {
        anchors.fill: launcherCard
        radius: launcherCard.radius
    }

    HyprlandFocusGrab {
        id: grab
        windows: [root]
    }
}
