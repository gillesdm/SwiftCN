import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SAlertPreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Alert Examples")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.foreground)
                
                Group {
                    // Default alert
                    SAlert(
                        title: "Default Alert",
                        description: "This is a default alert — check it out!",
                        variant: .default_
                    )
                    
                    // Destructive alert
                    SAlert(
                        title: "Destructive Alert",
                        description: "This action cannot be undone.",
                        variant: .destructive
                    )
                    
                    // Success alert
                    SAlert(
                        title: "Success Alert",
                        description: "Your changes have been saved successfully.",
                        variant: .success
                    )
                    
                    // Warning alert
                    SAlert(
                        title: "Warning Alert",
                        description: "Please back up your data before continuing.",
                        variant: .warning
                    )
                    
                    // Alert with custom icon
                    SAlert(
                        title: "Custom Icon",
                        description: "This alert uses a custom icon.",
                        variant: .default_,
                        icon: Image(systemName: "star.fill")
                    )
                    
                    // Alert with just a title
                    SAlert(
                        title: "Simple Alert",
                        variant: .default_
                    )
                    
                    // Alert with custom content
                    SAlert(
                        title: "Custom Content",
                        variant: .default_
                    ) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("You can add any SwiftUI view here.")
                                .foregroundColor(Colors.mutedForeground)
                            
                            SButton("Take Action", size: .sm) {
                                print("Button tapped")
                            }
                        }
                    }
                }
                .frame(maxWidth: 500)
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 40)
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
        
        // Dark mode preview
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Alert Examples")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.foreground)
                
                Group {
                    // Default alert
                    SAlert(
                        title: "Default Alert",
                        description: "This is a default alert — check it out!",
                        variant: .default_
                    )
                    
                    // Destructive alert
                    SAlert(
                        title: "Destructive Alert",
                        description: "This action cannot be undone.",
                        variant: .destructive
                    )
                }
                .frame(maxWidth: 500)
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 40)
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
