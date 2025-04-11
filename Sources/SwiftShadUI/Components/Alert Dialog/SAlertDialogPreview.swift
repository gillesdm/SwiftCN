import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SAlertDialogPreviews: PreviewProvider {
    struct AlertDialogDemo: View {
        @StateObject private var controller = AlertDialogController.shared
        
        var body: some View {
            ZStack {
                Colors.background.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: Spacing.xl) {
                    Text("Alert Dialog Examples")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Colors.foreground)
                    
                    // Standard dialog example
                    SAlertDialog { openAction in
                        SButton("Open Dialog") {
                            openAction()
                        }
                    } content: {
                        VStack(alignment: .leading, spacing: 0) {
                            SAlertDialogParts.Title("Are you sure?")
                            SAlertDialogParts.Description("This action cannot be undone. This will permanently remove your data from our servers.")
                            
                            SAlertDialogParts.Footer {
                                SButton("Cancel", variant: .outline) {
                                    controller.dismiss()
                                }
                                
                                SButton("Continue", variant: .primary) {
                                    controller.dismiss()
                                }
                            }
                        }
                    }
                    
                    // Destructive dialog example
                    SAlertDialog { openAction in
                        SButton("Delete Account", variant: .destructive) {
                            openAction()
                        }
                    } content: {
                        VStack(alignment: .leading, spacing: 0) {
                            SAlertDialogParts.Title("Delete Account")
                            SAlertDialogParts.Description("Are you sure you want to delete your account? All of your data will be permanently removed. This action cannot be undone.")
                            
                            SAlertDialogParts.Footer {
                                SButton("Cancel", variant: .ghost) {
                                    controller.dismiss()
                                }
                                
                                SButton("Delete", variant: .destructive) {
                                    controller.dismiss()
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .withAlertDialogs() // Add this modifier to enable global dialog support
        }
    }
    
    static var previews: some View {
        AlertDialogDemo()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Light Mode")
            .preferredColorScheme(.light)
        
        AlertDialogDemo()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
    }
}
