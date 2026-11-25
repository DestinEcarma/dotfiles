import QtQuick
import QtQuick.Controls

import qs.config

TextField {
    font.family: Config.fontFamily
    font.pixelSize: Config.fontSizeM
    color: Colors.textOnBackground
    placeholderTextColor: Colors.textOnSurfaceVariant
    background: null
    renderType: Text.NativeRendering
    verticalAlignment: TextInput.AlignVCenter
}
