import QtQuick
import QtQuick.Effects

import qs.config

RectangularShadow {
    z: -1
    opacity: 1
    blur: Config.shadowBlur
    spread: 0
    color: Config.shadowColor
    offset: Qt.point(0, Config.shadowOffsetY)
}
