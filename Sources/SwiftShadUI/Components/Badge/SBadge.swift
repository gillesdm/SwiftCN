import SwiftUI

public enum BadgeVariant {
    case default_
    case secondary
    case destructive
    case outline
    case success
    case warning
    case info
    
    var backgroundColor: Color {
        switch self {
        case .default_:
            return Colors.primary
        case .secondary:
            return Colors.secondary
        case .destructive:
            return Colors.destructive
        case .outline:
            return .clear
        case .success:
            return Colors.success
        case .warning:
            return Colors.warning
        case .info:
            return Colors.info
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .default_:
            return Colors.primaryForeground
        case .secondary:
            return Colors.secondaryForeground
        case .destructive:
            return Colors.destructiveForeground
        case .outline:
            return Colors.foreground
        case .success:
            return Colors.successForeground
        case .warning:
            return Colors.warningForeground
        case .info:
            return Colors.infoForeground
        }
    }
    
    var borderColor: Color {
        switch self {
        case .outline:
            return Colors.border
        default:
            return .clear
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
public struct SBadge: View {
    private let text: String
    private let variant: BadgeVariant
    
    public init(
        _ text: String,
        variant: BadgeVariant = .default_
    ) {
        self.text = text
        self.variant = variant
    }
    
    public var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .medium))
            .padding(.horizontal, 10)
            .padding(.vertical, 2)
            .foregroundColor(variant.foregroundColor)
            .background(variant.backgroundColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(variant.borderColor, lineWidth: 1)
            )
            .accessibilityLabel(text)
    }
}
