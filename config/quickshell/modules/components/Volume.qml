import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Pipewire

import qs.config

Rectangle {
    id: root

    property PwNode sink: Pipewire.defaultAudioSink

    implicitHeight: contentColumn.implicitHeight + Config.spacingS * 2
    Layout.fillWidth: true
    radius: Config.radiusM
    anchors.margins: 10

    color: Colors.surfaceContainerLow

    ColumnLayout {
        id: contentColumn
        anchors.fill: parent
        anchors.margins: Config.spacingS
        spacing: Config.spacingXS

        StyledText {
            text: "Sound"
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillHeight: true

            IconButton {
                implicitWidth: parent.height
                implicitHeight: parent.height
                icon: root.sink?.audio?.muted ? "volume_off" : "volume_up"
                iconText.font.pixelSize: Config.iconSizeS

                onActivated: {
                    if (root.sink?.audio)
                        root.sink.audio.muted = !root.sink.audio.muted;
                }
            }

            StyledSlider {
                id: slider

                width: parent.width

                PwObjectTracker {
                    objects: [root.sink]
                }

                Connections {
                    target: root.sink?.audio ?? null
                    function onVolumeChanged() {
                        if (!slider.pressed)
                            slider.value = (root.sink?.audio?.volume ?? 0) * 100;
                    }
                }

                onMoved: {
                    if (!root.sink?.audio)
                        return;
                    root.sink.audio.volume = value / 100;
                }

                WheelHandler {
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    onWheel: event => {
                        if (!root.sink?.audio)
                            return;

                        const step = 0.01;
                        const delta = event.angleDelta.y > 0 ? step : -step;
                        root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + delta));
                    }
                }
            }

            IconButton {
                implicitWidth: parent.height
                implicitHeight: parent.height
                icon: "chevron_forward"
                nudgeX: 1
                iconText.font.pixelSize: Config.iconSizeM

                // TODO:volume panel
            }
        }
    }
}
