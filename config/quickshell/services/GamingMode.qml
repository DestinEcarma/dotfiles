pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    property bool enabled: false

    function toggle() {
        enabled = !enabled;
    }
}
