import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SCheckboxPreviews: PreviewProvider {
    
    struct CheckboxDemo: View {
        @State private var isChecked1: Bool = false
        @State private var isChecked2: Bool = true
        @State private var isDisabledUnchecked: Bool = false
        @State private var isDisabledChecked: Bool = true
        @State private var termsAccepted: Bool = false

        var body: some View {
            ZStack {
                Colors.background.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: Spacing.xl) {
                    Text("Checkbox Examples")
                       .font(.system(size: 24, weight: .bold))
                       .foregroundColor(Colors.foreground)

                    // Basic States
                    VStack(alignment: .leading) {
                         Text("Basic States")
                            .font(.headline).foregroundColor(Colors.foreground)
                        HStack(spacing: Spacing.lg) {
                            HStack {
                                SCheckbox(isOn: $isChecked1)
                                Text("Unchecked").foregroundColor(Colors.foreground)
                            }
                            HStack {
                                SCheckbox(isOn: $isChecked2)
                                Text("Checked").foregroundColor(Colors.foreground)
                            }
                        }
                    }
                    
                    // Disabled States
                     VStack(alignment: .leading) {
                         Text("Disabled States")
                            .font(.headline).foregroundColor(Colors.foreground)
                        HStack(spacing: Spacing.lg) {
                            HStack {
                                SCheckbox(isOn: $isDisabledUnchecked)
                                Text("Unchecked").foregroundColor(Colors.mutedForeground) // Use muted color directly
                            }.disabled(true) // Apply disabled modifier to the container
                             HStack {
                                SCheckbox(isOn: $isDisabledChecked)
                                Text("Checked").foregroundColor(Colors.mutedForeground) // Use muted color directly
                            }.disabled(true)
                        }
                    }

                    // With Label (Common Usage)
                     VStack(alignment: .leading) {
                         Text("With Label")
                            .font(.headline).foregroundColor(Colors.foreground)
                         
                         // Use a Button for better accessibility when combining with label
                         LabeledCheckbox(label: "Accept terms and conditions", isOn: $termsAccepted)
                     }
                     
                     // Example disabled labeled checkbox
                     LabeledCheckbox(label: "Terms already accepted (disabled)", isOn: .constant(true))
                        .disabled(true) // Disable the labeled checkbox container

                }
                .padding()
            }
        }
    }

    /// Helper View for Labeled Checkbox to manage environment state correctly
    struct LabeledCheckbox: View {
        let label: String
        @Binding var isOn: Bool
        @Environment(\.isEnabled) private var isEnabled // Read environment here

        var body: some View {
            Button {
                if isEnabled { // Check if enabled before toggling
                   isOn.toggle()
                }
            } label: {
                 HStack(spacing: Spacing.sm) {
                    SCheckbox(isOn: $isOn)
                    Text(label)
                        .foregroundColor(isEnabled ? Colors.foreground : Colors.mutedForeground) // Use the read environment variable
                 }
            }
            .buttonStyle(.plain) // Use plain button style to avoid default button appearance
            .accessibilityElement(children: .combine) // Combine elements for VoiceOver
        }
    }

    static var previews: some View {
        CheckboxDemo()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Light Mode")
            .preferredColorScheme(.light)

        CheckboxDemo()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
    }
}
