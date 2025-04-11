import SwiftUI

struct ButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.md) {
            Group {
                Button("Primary", action: {})
                    .previewDisplayName("Primary Button")
                
                Button("Secondary", variant: .secondary, action: {})
                    .previewDisplayName("Secondary Button")
                
                Button("Outline", variant: .outline, action: {})
                    .previewDisplayName("Outline Button")
                
                Button("Ghost", variant: .ghost, action: {})
                    .previewDisplayName("Ghost Button")
                
                Button("Link", variant: .link, action: {})
                    .previewDisplayName("Link Button")
                
                Button("Destructive", variant: .destructive, action: {})
                    .previewDisplayName("Destructive Button")
            }
            
            Divider()
            
            Group {
                Button("Small", size: .sm, action: {})
                    .previewDisplayName("Small Button")
                
                Button("Medium", size: .md, action: {})
                    .previewDisplayName("Medium Button")
                
                Button("Large", size: .lg, action: {})
                    .previewDisplayName("Large Button")
            }
            
            Divider()
            
            Group {
                Button("Full Width", fullWidth: true, action: {})
                    .previewDisplayName("Full Width Button")
                
                Button("With Icon", icon: Image(systemName: "star.fill"), action: {})
                    .previewDisplayName("Button with Icon")
                
                Button("Icon Trailing",
                       icon: Image(systemName: "arrow.right"),
                       iconPosition: .trailing,
                       action: {})
                    .previewDisplayName("Button with Trailing Icon")
                
                Button("Disabled", isEnabled: false, action: {})
                    .previewDisplayName("Disabled Button")
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
