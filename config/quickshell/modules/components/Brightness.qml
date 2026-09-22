import QtQuick
import QtQuick.Layouts

import qs.services

StyledSlider {
    id: brightnessSlider
    Layout.fillWidth: true
    visible: Brightness.available

    value: Brightness.brightness * 100

    Component.onCompleted: {
        value = Brightness.brightness * 100;
    }

    Connections {
        target: Brightness
        function onBrightnessChanged() {
            if (!brightnessSlider.pressed)
                brightnessSlider.value = Brightness.brightness * 100;
        }
    }

    onMoved: value => Brightness.setBrightness(value / 100)

    WheelHandler {
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => {
            if (!Brightness.available)
                return;
            const step = 0.01;
            const delta = event.angleDelta.y > 0 ? step : -step;
            Brightness.setBrightness(Brightness.brightness + delta);
        }
    }
}
