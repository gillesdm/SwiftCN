import SwiftUI

/// Design system colors
public enum Colors {
    /// The background color of the application.
    public static let background = Color("background", bundle: .module)
    
    /// The primary foreground color used for text and icons.
    public static let foreground = Color("foreground", bundle: .module)
    
    /// The primary color used for buttons and highlights.
    public static let primary = Color("primary", bundle: .module)
    
    /// The foreground color used on primary elements.
    public static let primaryForeground = Color("primaryForeground", bundle: .module)
    
    /// The secondary color used for less prominent elements.
    public static let secondary = Color("secondary", bundle: .module)
    
    /// The foreground color used on secondary elements.
    public static let secondaryForeground = Color("secondaryForeground", bundle: .module)
    
    /// A muted color used for backgrounds and less important elements.
    public static let muted = Color("muted", bundle: .module)
    
    /// The foreground color used on muted elements.
    public static let mutedForeground = Color("mutedForeground", bundle: .module)
    
    /// The color used for card backgrounds.
    public static let card = Color("card", bundle: .module)
    
    /// The foreground color used on card elements.
    public static let cardForeground = Color("cardForeground", bundle: .module)
    
    /// The color used for borders.
    public static let border = Color("border", bundle: .module)
    
    /// The color used for input fields.
    public static let input = Color("input", bundle: .module)
    
    /// The ring color used for focus indicators.
    public static let ring = primary.opacity(0.3)
    
    /// An accent color used for highlighting important elements.
    public static let accent = Color("accent", bundle: .module)
    
    /// The foreground color used on accent elements.
    public static let accentForeground = Color("accentForeground", bundle: .module)
    
    /// The color used to indicate successful actions or states.
    public static let success = Color("success", bundle: .module)
    
    /// The foreground color used on success elements.
    public static let successForeground = Color("successForeground", bundle: .module)
    
    /// The color used to indicate warnings.
    public static let warning = Color("warning", bundle: .module)
    
    /// The foreground color used on warning elements.
    public static let warningForeground = Color("warningForeground", bundle: .module)
    
    /// The color used to indicate destructive actions.
    public static let destructive = Color("destructive", bundle: .module)
    
    /// The foreground color used on destructive elements.
    public static let destructiveForeground = Color("destructiveForeground", bundle: .module)
    
    /// The color used to convey informational messages.
    public static let info = Color("info", bundle: .module)
    
    /// The foreground color used on informational elements.
    public static let infoForeground = Color("infoForeground", bundle: .module)
    
    /// The color used to indicate focus.
    public static let focus = Color("focus", bundle: .module)
    
    /// The color used for popover backgrounds.
    public static let popover = Color("popover", bundle: .module)
    
    /// The foreground color used on popover elements.
    public static let popoverForeground = Color("popoverForeground", bundle: .module)
    
    /// The color used for tooltips.
    public static let tooltip = Color("tooltip", bundle: .module)
    
    /// The foreground color used on tooltip elements.
    public static let tooltipForeground = Color("tooltipForeground", bundle: .module)
    
    /// The color used for highlighting elements.
    public static let highlight = Color("highlight", bundle: .module)
    
    // MARK: - Utility colors with transparency
    /// A color used for overlays, typically semi-transparent.
    public static let overlay = Color("overlay", bundle: .module)
    
    /// A color used for shadows.
    public static let shadow = Color("shadow", bundle: .module)
    
    /// A lighter shadow color used for subtle effects.
    public static let shadowLight = Color("shadowLight", bundle: .module)
}
