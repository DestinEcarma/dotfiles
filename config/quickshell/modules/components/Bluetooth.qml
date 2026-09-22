import QtQuick

import Quickshell.Bluetooth

Capsule {
    property int connectedDeviceCount: Bluetooth.devices.values.filter(device => device.connected).length
    property bool bluetoothAvailable: Bluetooth.defaultAdapter !== null

    icon: bluetoothAvailable ? "bluetooth" : "bluetooth_disabled"
    label: "Bluetooth"
    caption: {
        if (connectedDeviceCount === 0)
            return "";

        if (connectedDeviceCount === 1)
            return "1 device";

        return `${connectedDeviceCount} devices`;
    }
    captionEnabled: connectedDeviceCount > 0
    iconToggled: Bluetooth.defaultAdapter?.enabled ?? false
    iconInteractive: bluetoothAvailable

    onIconActivated: {
        if (Bluetooth.defaultAdapter)
            Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
    }
}
