pragma Singleton

import QtQuick

import Quickshell

Singleton {
    readonly property color primary: "{{colors.primary.default.hex}}"
    readonly property color textOnPrimary: "{{colors.on_primary.default.hex}}"
    readonly property color primaryContainer: "{{colors.primary_container.default.hex}}"
    readonly property color textOnPrimaryContainer: "{{colors.on_primary_container.default.hex}}"

    readonly property color secondary: "{{colors.secondary.default.hex}}"
    readonly property color textOnSecondary: "{{colors.on_secondary.default.hex}}"
    readonly property color secondaryContainer: "{{colors.secondary_container.default.hex}}"
    readonly property color textOnSecondaryContainer: "{{colors.on_secondary_container.default.hex}}"

    readonly property color tertiary: "{{colors.tertiary.default.hex}}"
    readonly property color textOnTertiary: "{{colors.on_tertiary.default.hex}}"
    readonly property color tertiaryContainer: "{{colors.tertiary_container.default.hex}}"
    readonly property color textOnTertiaryContainer: "{{colors.on_tertiary_container.default.hex}}"

    readonly property color error: "{{colors.error.default.hex}}"
    readonly property color textOnError: "{{colors.on_error.default.hex}}"
    readonly property color errorContainer: "{{colors.error_container.default.hex}}"
    readonly property color textOnErrorContainer: "{{colors.on_error_container.default.hex}}"

    readonly property color background: "{{colors.background.default.hex}}"
    readonly property color textOnBackground: "{{colors.on_background.default.hex}}"

    readonly property color surface: "{{colors.surface.default.hex}}"
    readonly property color surfaceDim: "{{colors.surface_dim.default.hex}}"
    readonly property color surfaceBright: "{{colors.surface_bright.default.hex}}"
    readonly property color surfaceContainerLowest: "{{colors.surface_container_lowest.default.hex}}"
    readonly property color surfaceContainerLow: "{{colors.surface_container_low.default.hex}}"
    readonly property color surfaceContainer: "{{colors.surface_container.default.hex}}"
    readonly property color surfaceContainerHigh: "{{colors.surface_container_high.default.hex}}"
    readonly property color surfaceContainerHighest: "{{colors.surface_container_highest.default.hex}}"
    readonly property color textOnSurface: "{{colors.on_surface.default.hex}}"
    readonly property color textOnSurfaceVariant: "{{colors.on_surface_variant.default.hex}}"

    readonly property color outline: "{{colors.outline.default.hex}}"
    readonly property color outlineVariant: "{{colors.outline_variant.default.hex}}"

    readonly property color inverseSurface: "{{colors.inverse_surface.default.hex}}"
    readonly property color textInverseOnSurface: "{{colors.inverse_on_surface.default.hex}}"
    readonly property color inversePrimary: "{{colors.inverse_primary.default.hex}}"
}
