import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.config
import qs.modules.components

RowLayout {
    id: root
    spacing: 0

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    property int hours: clock.date.getHours()
    property int minutes: clock.date.getMinutes()

    RollingDigit {
        value: Math.floor(root.hours / 10 % 10)
        font.family: Config.fontFamilyMono
        font.bold: true
    }

    RollingDigit {
        value: root.hours % 10
        font.family: Config.fontFamilyMono
        font.bold: true
    }

    StyledText {
        text: ":"
        font.family: Config.fontFamilyMono
        font.bold: true
        rightPadding: -2
    }

    RollingDigit {
        value: Math.floor(root.minutes / 10 % 10)
        font.family: Config.fontFamilyMono
        font.bold: true
    }

    RollingDigit {
        value: root.minutes % 10
        font.family: Config.fontFamilyMono
        font.bold: true
    }
}
