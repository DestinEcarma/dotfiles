import QtQuick

import qs.modules.bar.panels

Loader {
    id: root

    sourceComponent: controlCenterComp

    Component {
        id: controlCenterComp
        ControlCenterPanel {
            onNetworkRequested: root.sourceComponent = networkPanelComp
            onBluetoothRequested: root.sourceComponent = bluetoothPanelComp
        }
    }
    Component {
        id: networkPanelComp
        NetworkPanel {
            onBackRequested: root.sourceComponent = controlCenterComp
        }
    }
    Component {
        id: bluetoothPanelComp
        BluetoothPanel {
            onBackRequested: root.sourceComponent = controlCenterComp
        }
    }
}
