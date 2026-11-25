//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

import qs.modules.bar
import qs.modules.launcher

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
}
