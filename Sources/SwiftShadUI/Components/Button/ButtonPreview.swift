import SwiftUI

struct SButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.md) {
            Group {
                SButton("Primary", action: {})
                    .previewDisplayName("Primary Button")
                
                SButton("Secondary", variant: .secondary, action: {})
                    .previewDisplayName("Secondary Button")
                
                SButton("Outline", variant: .outline, action: {})
                    .previewDisplayName("Outline Button")
                
                SButton("Ghost", variant: .ghost, action: {})
                    .previewDisplayName("Ghost Button")
                
                SButton("Link", variant: .link, action: {})
                    .previewDisplayName("Link Button")
                
                SButton("Destructive", variant: .destructive, action: {})
                    .previewDisplayName("Destructive Button")
            }
            
            Divider()
            
            Group {
                SButton("Small", size: .sm, action: {})
                    .previewDisplayName("Small Button")
                
                SButton("Medium", size: .md, action: {})
                    .previewDisplayName("Medium Button")
                
                SButton("Large", size: .lg, action: {})
                    .previewDisplayName("Large Button")
            }
            
            Divider()
            
            Group {
                SButton("Full Width", fullWidth: true, action: {})
                    .previewDisplayName("Full Width Button")
                
                SButton("With Icon", icon: Image(systemName: "star.fill"), action: {})
                    .previewDisplayName("Button with Icon")
                
                SButton("Icon Trailing",
                       icon: Image(systemName: "arrow.right"),
                       iconPosition: .trailing,
                       action: {})
                    .previewDisplayName("Button with Trailing Icon")
                
                SButton("Disabled", isEnabled: false, action: {})
                    .previewDisplayName("Disabled Button")
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
