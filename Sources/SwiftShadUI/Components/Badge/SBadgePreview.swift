import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SBadgePreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) {
                 Text("Badge Examples")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.foreground)

                // Group variants for easy viewing
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Variants").font(.headline).foregroundColor(Colors.foreground)
                    HStack(spacing: Spacing.sm) {
                        SBadge("Default") // Uses .default_
                        SBadge("Secondary", variant: .secondary)
                        SBadge("Destructive", variant: .destructive)
                        SBadge("Outline", variant: .outline)
                    }
                    HStack(spacing: Spacing.sm) {
                        SBadge("Success", variant: .success)
                        SBadge("Warning", variant: .warning)
                        SBadge("Info", variant: .info)
                    }
                }
                
                // Example usage
                 VStack(alignment: .leading, spacing: Spacing.md) {
                     Text("Usage Example").font(.headline).foregroundColor(Colors.foreground)
                     HStack(spacing: Spacing.lg) {
                        Text("Status:").foregroundColor(Colors.foreground)
                        SBadge("Active", variant: .success)
                        
                        Text("Tag:").foregroundColor(Colors.foreground)
                        SBadge("v1.2.0", variant: .secondary)
                        
                        Text("Error Code:").foregroundColor(Colors.foreground)
                        SBadge("404", variant: .destructive)
                     }
                 }

            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Light Mode")
        .preferredColorScheme(.light)

        // Dark mode preview
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                 Text("Badge Examples (Dark)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.foreground)

                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Variants").font(.headline).foregroundColor(Colors.foreground)
                    HStack(spacing: Spacing.sm) {
                        SBadge("Default")
                        SBadge("Secondary", variant: .secondary)
                        SBadge("Destructive", variant: .destructive)
                        SBadge("Outline", variant: .outline)
                        SBadge("Success", variant: .success)
                    }
                }
            }
            .padding()

        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Dark Mode")
        .preferredColorScheme(.dark)
    }
}
