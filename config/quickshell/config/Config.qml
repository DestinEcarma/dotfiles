pragma Singleton

import QtQuick

import Quickshell

Singleton {
    id: root

    // ------------------------------------------------------------------
    // Spacing scale
    // ------------------------------------------------------------------
    readonly property int spacingXXS: 2
    readonly property int spacingXS: 4
    readonly property int spacingS: 8
    readonly property int spacingM: 12
    readonly property int spacingL: 16
    readonly property int spacingXL: 24
    readonly property int spacingXXL: 32
    readonly property int barMargin: 10

    // ------------------------------------------------------------------
    // Radius scale
    // ------------------------------------------------------------------
    readonly property int radiusXS: 4
    readonly property int radiusS: 8
    readonly property int radiusM: 12
    readonly property int radiusL: 16

    // ------------------------------------------------------------------
    // Font family
    // ------------------------------------------------------------------
    readonly property string fontFamily: "Inter"
    readonly property string fontFamilyMono: "JetBrains Mono"
    readonly property string iconFontFamily: "Material Symbols Rounded"

    // ------------------------------------------------------------------
    // Font sizes
    // ------------------------------------------------------------------
    readonly property int fontSizeXS: 10
    readonly property int fontSizeS: 12
    readonly property int fontSizeM: 14
    readonly property int fontSizeL: 16
    readonly property int fontSizeXL: 20
    readonly property int fontSizeXXL: 24
    readonly property int fontSizeHuge: 32

    // ------------------------------------------------------------------
    // Icon sizes
    // ------------------------------------------------------------------
    readonly property int iconSizeXS: 16
    readonly property int iconSizeS: 20
    readonly property int iconSizeM: 24
    readonly property int iconSizeL: 32
    readonly property int iconSizeXL: 40
    readonly property int iconSizeXXL: 48
    readonly property int iconSizeXXXL: 64

    // ------------------------------------------------------------------
    // Animation durations & easing
    // ------------------------------------------------------------------
    readonly property int animationFast: 120
    readonly property int animationNormal: 200
    readonly property int animationSlow: 350

    readonly property int easingStandard: Easing.OutQuad
    readonly property int easingEmphasized: Easing.OutCubic
    readonly property list<real> emphasizedBezier: [0.05, 0.7, 0.1, 1.0, 1, 1]

    // ------------------------------------------------------------------
    // Elevation / shadow
    // ------------------------------------------------------------------
    readonly property color shadowColor: "#A0000000"
    readonly property int shadowOffsetY: 4

    readonly property int shadowSm: 4
    readonly property int shadowBlur: 8
    readonly property int shadowMd: 16
    readonly property int shadowLg: 24
}
