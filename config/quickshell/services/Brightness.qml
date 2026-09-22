pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property bool available: brightnessProc.running && brightness > 0
    property real brightness: 1.0

    function setBrightness(value) {
        if (!available)
            return;
        brightness = Math.max(0, Math.min(1, value));
        setProc.command = ["brightnessctl", "set", `${Math.round(brightness * 100)}%`];
        setProc.running = true;
    }

    function stepBrightness(delta) {
        if (!available)
            return;
        setBrightness(brightness + delta);
    }

    Process {
        id: brightnessProc
        command: ["brightnessctl", "g"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const max = parseInt(data.trim()) || 1;
                root.brightness = max > 0 ? 1.0 : 0.0;
            }
        }
    }
}
