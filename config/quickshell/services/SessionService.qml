pragma Singleton

import QtQuick

import Quickshell

Singleton {
    id: root

    function _run(cmd) {
        console.log(cmd);
        Quickshell.execDetached(["sh", "-c", cmd]);
    }

    function lock() {
        root._run("loginctl lock-session");
    }

    function logout() {
        root._run("command -v hyprshutdown >/dev/null 2>&1 && " + "hyprshutdown -t 'Logging out...' || " + "hyprctl dispatch exit");
    }

    function suspend() {
        root._run("systemctl suspend");
    }

    function hibernate() {
        root._run("systemctl hibernate");
    }

    function reboot() {
        root._run("command -v hyprshutdown >/dev/null 2>&1 && " + "hyprshutdown -t 'Restarting...' --post-cmd 'systemctl reboot' || " + "systemctl reboot");
    }

    function shutdown() {
        root._run("command -v hyprshutdown >/dev/null 2>&1 && " + "hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff' || " + "systemctl poweroff");
    }
}
