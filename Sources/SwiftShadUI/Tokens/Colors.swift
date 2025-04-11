import SwiftUI

/// Design system colors
public enum Colors {
    // Base
    public static let background = Color("background", bundle: .module)
    public static let foreground = Color("foreground", bundle: .module)
    
    // Primary
    public static let primary = Color("primary", bundle: .module)
    public static let primaryForeground = Color("primaryForeground", bundle: .module)
    
    // Secondary
    public static let secondary = Color("secondary", bundle: .module)
    public static let secondaryForeground = Color("secondaryForeground", bundle: .module)
    
    // Destructive
    public static let destructive = Color("destructive", bundle: .module)
    public static let destructiveForeground = Color("destructiveForeground", bundle: .module)
    
    // Muted
    public static let muted = Color("muted", bundle: .module)
    public static let mutedForeground = Color("mutedForeground", bundle: .module)
    
    // Card
    public static let card = Color("card", bundle: .module)
    public static let cardForeground = Color("cardForeground", bundle: .module)
    
    // Border
    public static let border = Color("border", bundle: .module)
    
    // Input
    public static let input = Color("input", bundle: .module)
    
    // Ring
    public static let ring = primary.opacity(0.3)
}

// Color extension to support dark/light mode programmatically
extension Color {
    static func dynamicColor(light: Color, dark: Color) -> Color {
        #if os(iOS)
        return Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default:
                return UIColor(light)
            }
        })
        #else
        return light
        #endif
    }
}
