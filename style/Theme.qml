pragma Singleton
import QtQuick

QtObject {
    // ═══════════════════════════════════════════════════════════
    // CATPPUCCIN MOCHA - Palette complète
    // ═══════════════════════════════════════════════════════════
    
    // Accent colors
    readonly property color rosewater: "#f5e0dc"
    readonly property color flamingo:  "#f2cdcd"
    readonly property color pink:      "#f5c2e7"
    readonly property color mauve:     "#cba6f7"
    readonly property color red:       "#f38ba8"
    readonly property color maroon:    "#eba0ac"
    readonly property color peach:     "#fab387"
    readonly property color yellow:    "#f9e2af"
    readonly property color green:     "#a6e3a1"
    readonly property color teal:      "#94e2d5"
    readonly property color sky:       "#89dceb"
    readonly property color sapphire:  "#74c7ec"
    readonly property color blue:      "#89b4fa"
    readonly property color lavender:  "#b4befe"
    
    // Base colors
    readonly property color text:      "#cdd6f4"
    readonly property color subtext1:  "#bac2de"
    readonly property color subtext0:  "#a6adc8"
    readonly property color overlay2:  "#9399b2"
    readonly property color overlay1:  "#7f849c"
    readonly property color overlay0:  "#6c7086"
    readonly property color surface2:  "#585b70"
    readonly property color surface1:  "#45475a"
    readonly property color surface0:  "#313244"
    readonly property color base:      "#1e1e2e"
    readonly property color mantle:    "#181825"
    readonly property color crust:     "#11111b"

    // ═══════════════════════════════════════════════════════════
    // SEMANTIC COLORS (selon le style guide officiel)
    // ═══════════════════════════════════════════════════════════
    
    // Backgrounds
    readonly property color bgPrimary:   base      // fond principal
    readonly property color bgSecondary: mantle    // panneaux secondaires
    readonly property color bgTertiary:  crust     // le plus sombre
    
    // Surfaces (éléments flottants, cartes, boutons)
    readonly property color surfaceLowest:  surface0
    readonly property color surfaceLow:     surface1
    readonly property color surfaceHigh:    surface2
    
    // Overlays (menus, tooltips, popups)
    readonly property color overlayLowest:  overlay0
    readonly property color overlayLow:     overlay1
    readonly property color overlayHigh:    overlay2
    
    // Typography
    readonly property color textPrimary:   text      // corps de texte
    readonly property color textSecondary: subtext1  // sous-titres
    readonly property color textTertiary:  subtext0  // labels
    readonly property color textSubtle:    overlay1  // texte discret
    readonly property color textOnAccent:  crust     // texte sur fond coloré
    
    // Semantic states
    readonly property color link:    blue
    readonly property color success: green
    readonly property color warning: yellow
    readonly property color error:   red
    
    // Interactive
    readonly property color cursor:    rosewater
    readonly property color selection: Qt.rgba(overlay2.r, overlay2.g, overlay2.b, 0.25)
    readonly property color accent:    mauve       // accent principal (personnalisable)
    readonly property color accentAlt: lavender    // accent secondaire
    
    // Borders
    readonly property color borderSubtle: surface1
    readonly property color borderStrong: surface2

    // ═══════════════════════════════════════════════════════════
    // DIMENSIONS
    // ═══════════════════════════════════════════════════════════
    
    readonly property int radiusSm: 4
    readonly property int radiusMd: 8
    readonly property int radiusLg: 12
    
    readonly property int paddingSm: 4
    readonly property int paddingMd: 8
    readonly property int paddingLg: 16
    
    readonly property int fontSm: 11
    readonly property int fontMd: 13
    readonly property int fontLg: 16
    readonly property int fontXl: 20

    // ═══════════════════════════════════════════════════════════
    // HELPERS
    // ═══════════════════════════════════════════════════════════
    
    function withAlpha(color, alpha) {
        return Qt.rgba(color.r, color.g, color.b, alpha)
    }
}
