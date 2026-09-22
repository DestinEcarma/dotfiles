pragma Singleton

import QtQuick

import Quickshell

Singleton {
    property var grab: null

    function requestFocus() {
        if (grab)
            grab.active = true;
    }

    function releaseFocus() {
        if (grab)
            grab.active = false;
    }
}
