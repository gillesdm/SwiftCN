import SwiftUI

public struct SButton: View {
    private let title: String
    private let variant: ButtonVariant
    private let size: ButtonSize
    private let fullWidth: Bool
    private let icon: Image?
    private let iconPosition: IconPosition
    private let action: () -> Void
    private let isEnabled: Bool
    
    @State private var isPressed = false
    
    public enum IconPosition {
        case leading, trailing
    }
    
    public init(
        _ title: String,
        variant: ButtonVariant = .primary,
        size: ButtonSize = .md,
        fullWidth: Bool = false,
        icon: Image? = nil,
        iconPosition: IconPosition = .leading,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.size = size
        self.fullWidth = fullWidth
        self.icon = icon
        self.iconPosition = iconPosition
        self.isEnabled = isEnabled
        self.action = action
    }
    
    public var body: some View {
        SwiftUI.Button(action: {
            if isEnabled {
                action()
            }
        }) {
            HStack(spacing: Spacing.xs) {
                if let icon = icon, iconPosition == .leading {
                    icon
                        .font(size.font.font)
                }
                
                Text(title)
                    .typography(size.font)
                
                if let icon = icon, iconPosition == .trailing {
                    icon
                        .font(size.font.font)
                }
            }
            .padding(size.padding)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(
                variant.getBackgroundColor(isPressed: isPressed, isEnabled: isEnabled)
            )
            .foregroundColor(variant.foregroundColor.opacity(isEnabled ? 1 : 0.5))
            .cornerRadius(size.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: size.cornerRadius)
                    .stroke(variant.borderColor ?? .clear, lineWidth: variant.borderColor != nil ? 1 : 0)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEnabled)
        .pressAction(onPress: {
            isPressed = true
        }, onRelease: {
            isPressed = false
        })
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
    }
}

struct PressActionModifier: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in onPress() }
                    .onEnded { _ in onRelease() }
            )
    }
}

extension View {
    func pressAction(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        modifier(PressActionModifier(onPress: onPress, onRelease: onRelease))
    }
}
