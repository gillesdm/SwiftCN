import SwiftUI

/// A checkbox control inspired by shadcn/ui.
/// Allows users to select or deselect an option.
@available(iOS 15.0, macOS 12.0, *)
public struct SCheckbox: View {
    @Binding private var isOn: Bool
    @Environment(\.isEnabled) private var isEnabled
    @State private var isPressed: Bool = false

    private let size: CGFloat = 16 // Standard size for the checkbox square
    private let cornerRadius: CGFloat = 4 // Slightly rounded corners
    private let checkmarkSize: CGFloat = 10 // Size of the checkmark icon

    /// Creates a new checkbox bound to a boolean state.
    /// - Parameter isOn: A binding to a Boolean value that determines whether the checkbox is selected.
    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }

    public var body: some View {
        ZStack {
            // Background and Border
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(isEnabled ? (isOn ? Color.clear : Colors.border) : Colors.border.opacity(0.5), lineWidth: 1.5) // Border color changes when checked
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(isEnabled ? (isOn ? Colors.primary : Color.clear) : Colors.muted.opacity(0.5)) // Fill color changes when checked or disabled
                )
                .frame(width: size, height: size)

            // Checkmark Icon (appears when isOn is true)
            if isOn {
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    // Fixed: Apply weight within the font modifier for macOS 12 compatibility
                    .font(.system(size: checkmarkSize, weight: .bold))
                    .foregroundColor(isEnabled ? Colors.primaryForeground : Colors.mutedForeground.opacity(0.8))
                    .frame(width: checkmarkSize, height: checkmarkSize) // Ensure frame is applied
                    .transition(.scale(scale: 0.5).combined(with: .opacity)) // Add a subtle transition
            }
        }
        .scaleEffect(isPressed ? 0.95 : 1.0) // Subtle press effect
        .animation(.spring(response: 0.2, dampingFraction: 0.6), value: isPressed)
        .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isOn) // Animate checkmark appearance
        .contentShape(Rectangle()) // Ensure the whole area is tappable
        .onTapGesture {
            if isEnabled {
                isOn.toggle()
            }
        }
        // Simulate press effect for tap gesture
        .simultaneousGesture(
             DragGesture(minimumDistance: 0)
                 .onChanged { _ in if isEnabled { isPressed = true } }
                 .onEnded { _ in if isEnabled { isPressed = false } }
        )
        .accessibilityElement(children: .ignore)
        .accessibilityValue(isOn ? "Checked" : "Unchecked")
        .accessibilityLabel("Checkbox") // Consider allowing a custom label if used standalone
    }
}
