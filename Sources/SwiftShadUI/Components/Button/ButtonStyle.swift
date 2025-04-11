import SwiftUI

public enum ButtonVariant {
    case primary
    case secondary
    case outline
    case ghost
    case link
    case destructive
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return Colors.primary
        case .secondary:
            return Colors.secondary
        case .outline, .ghost, .link:
            return .clear
        case .destructive:
            return Colors.destructive
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary:
            return Colors.primaryForeground
        case .secondary:
            return Colors.secondaryForeground
        case .outline:
            return Colors.foreground
        case .ghost:
            return Colors.foreground
        case .link:
            return Colors.primary
        case .destructive:
            return Colors.destructiveForeground
        }
    }
    
    var borderColor: Color? {
        switch self {
        case .outline:
            return Colors.border
        default:
            return nil
        }
    }
    
    func getBackgroundColor(isPressed: Bool, isEnabled: Bool) -> Color {
        guard isEnabled else {
            return backgroundColor.opacity(0.5)
        }
        
        if isPressed {
            switch self {
            case .primary:
                return Colors.primary.opacity(0.9)
            case .secondary:
                return Colors.secondary.opacity(0.9)
            case .outline:
                return Colors.muted.opacity(0.2)
            case .ghost:
                return Colors.muted.opacity(0.2)
            case .link:
                return .clear
            case .destructive:
                return Colors.destructive.opacity(0.9)
            }
        }
        
        return backgroundColor
    }
}

public enum ButtonSize {
    case sm, md, lg
    
    var padding: EdgeInsets {
        switch self {
        case .sm:
            return EdgeInsets(top: Spacing.xxs, leading: Spacing.xs, bottom: Spacing.xxs, trailing: Spacing.xs)
        case .md:
            return EdgeInsets(top: Spacing.xs, leading: Spacing.md, bottom: Spacing.xs, trailing: Spacing.md)
        case .lg:
            return EdgeInsets(top: Spacing.sm, leading: Spacing.lg, bottom: Spacing.sm, trailing: Spacing.lg)
        }
    }
    
    var font: Typography {
        switch self {
        case .sm:
            return .small
        case .md:
            return .base
        case .lg:
            return .large
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .sm:
            return 6
        case .md:
            return 8
        case .lg:
            return 10
        }
    }
}
