import SwiftUI

public enum AlertVariant {
    case default_
    case destructive
    case success
    case warning
    
    var borderColor: Color {
        switch self {
        case .default_:
            return Colors.border
        case .destructive:
            return Colors.destructive.opacity(0.5)
        case .success:
            return Colors.success.opacity(0.5)
        case .warning:
            return Colors.warning.opacity(0.5)
        }
    }
    
    var iconColor: Color {
        switch self {
        case .default_:
            return Colors.foreground
        case .destructive:
            return Colors.destructive
        case .success:
            return Colors.success
        case .warning:
            return Colors.warning
        }
    }
    
    var defaultIcon: String {
        switch self {
        case .default_:
            return "info.circle.fill"
        case .destructive:
            return "exclamationmark.triangle.fill"
        case .success:
            return "checkmark.circle.fill"
        case .warning:
            return "exclamationmark.circle.fill"
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
public struct SAlert<Content: View>: View {
    private let title: String?
    private let variant: AlertVariant
    private let icon: Image?
    private let content: Content
    
    public init(
        title: String? = nil,
        variant: AlertVariant = .default_,
        icon: Image? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.variant = variant
        self.icon = icon
        self.content = content()
    }
    
    public init(
        title: String,
        variant: AlertVariant = .default_,
        icon: Image? = nil
    ) where Content == EmptyView {
        self.title = title
        self.variant = variant
        self.icon = icon
        self.content = EmptyView()
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let icon = icon {
                icon
                    .foregroundColor(variant.iconColor)
                    .font(.system(size: 16))
            } else {
                Image(systemName: variant.defaultIcon)
                    .foregroundColor(variant.iconColor)
                    .font(.system(size: 16))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                if let title = title {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Colors.foreground)
                }
                
                content
                    .font(.system(size: 14))
                    .foregroundColor(Colors.mutedForeground)
            }
            
            Spacer()
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Colors.background)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(variant.borderColor, lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
    }
}

public extension SAlert where Content == Text {
    init(
        title: String? = nil,
        description: String,
        variant: AlertVariant = .default_,
        icon: Image? = nil
    ) {
        self.init(
            title: title,
            variant: variant,
            icon: icon
        ) {
            Text(description)
        }
    }
}
