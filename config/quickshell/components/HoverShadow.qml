import QtQuick
import QtQuick.Effects

import qs.config

RectangularShadow {
    id: root

    property bool hovered: false
    property bool _renderVisible: false

    z: -1
    opacity: hovered ? 1 : 0
    visible: _renderVisible
    blur: Config.shadowBlur
    spread: 0
    color: Config.shadowColor
    offset: Qt.point(0, Config.shadowOffsetY)

    onHoveredChanged: {
        if (hovered)
            _renderVisible = true;
        else
            visibleTimer.restart();
    }

    Timer {
        id: visibleTimer
        interval: Config.animationFast
        running: false
        repeat: false
        onTriggered: {
            root._renderVisible = false;
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: Config.animationFast
        }
    }
}
