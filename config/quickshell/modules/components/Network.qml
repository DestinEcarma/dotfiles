import QtQuick

import Quickshell.Networking

Capsule {
    property NetworkDevice activeDevice: {
        const devices = Networking.devices.values;

        return devices.find(device => device.type === DeviceType.Wired && device.networks.values.some(network => network.connected)) ?? devices.find(device => device.type === DeviceType.Wifi && device.networks.values.some(network => network.connected)) ?? null;
    }

    property Network activeNetwork: activeDevice?.networks.values.find(network => network.connected) ?? null

    property bool connected: activeNetwork !== null
    property bool isWifi: activeDevice?.type === DeviceType.Wifi
    property bool isWired: activeDevice?.type === DeviceType.Wired

    icon: isWired ? "cable" : "wifi"
    label: isWired ? "Ethernet" : "Wi-Fi"
    caption: isWifi ? activeNetwork?.name : ""
    captionEnabled: isWifi && connected
    iconToggled: isWired || Networking.wifiEnabled
    iconInteractive: !isWired

    onIconActivated: {
        if (isWifi || !Networking.wifiEnabled)
            Networking.wifiEnabled = !Networking.wifiEnabled;
    }
}
