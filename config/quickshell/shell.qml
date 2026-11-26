//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

import qs.modules.bar
import qs.modules.launcher
import qs.services

ShellRoot {
    Bar {}
    Launcher {
        id: launcher
    }

    IpcHandler {
        target: "launcher"

        function toggle() {
            launcher.toggle();
        }
    }

    IpcHandler {
        target: "gaming_mode"

        function toggle() {
            GamingMode.toggle();
        }
    }
}
