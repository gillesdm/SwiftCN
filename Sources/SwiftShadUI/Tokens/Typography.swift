import SwiftUI

/// Design system typography
public enum Typography {
    case h1, h2, h3, h4
    case large, base, small, muted
    
    public var font: Font {
        switch self {
        case .h1:
            return .system(size: 36, weight: .bold)
        case .h2:
            return .system(size: 30, weight: .bold)
        case .h3:
            return .system(size: 24, weight: .bold)
        case .h4:
            return .system(size: 20, weight: .semibold)
        case .large:
            return .system(size: 18)
        case .base:
            return .system(size: 16)
        case .small:
            return .system(size: 14)
        case .muted:
            return .system(size: 14, weight: .light)
        }
    }
}

// Typography modifiers for easy usage
public extension View {
    func typography(_ style: Typography) -> some View {
        self.font(style.font)
    }
}
