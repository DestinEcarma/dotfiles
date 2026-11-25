import QtQuick

import qs.config

Text {
    font.family: Config.fontFamily
    font.pixelSize: Config.fontSizeM
    color: Colors.textOnBackground
    renderType: Text.NativeRendering
}
