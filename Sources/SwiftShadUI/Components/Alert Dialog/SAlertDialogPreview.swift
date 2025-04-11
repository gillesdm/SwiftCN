import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SAlertDialogPreviews: PreviewProvider {
    struct AlertDialogDemo: View {
        @State private var showDialog = false
        @State private var showDeleteDialog = false
        
        var body: some View {
            ZStack {
                Colors.background.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: Spacing.xl) {
                    Text("Alert Dialog Examples")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Colors.foreground)
                    
                    // Standard dialog example - updated to pass open action to button
                    SAlertDialog(isOpen: $showDialog) { openAction in
                        SButton("Open Dialog") {
                            print("Button tapped, calling openAction")
                            openAction()
                        }
                    } content: {
                        VStack(alignment: .leading, spacing: 0) {
                            SAlertDialogParts.Title("Are you sure?")
                            SAlertDialogParts.Description("This action cannot be undone. This will permanently remove your data from our servers.")
                            
                            SAlertDialogParts.Footer {
                                SButton("Cancel", variant: .outline) {
                                    print("Cancel button tapped")
                                    showDialog = false
                                }
                                
                                SButton("Continue", variant: .destructive) {
                                    print("Continue button tapped")
                                    showDialog = false
                                }
                            }
                        }
                    }
                    
                    // Destructive dialog example - updated to pass open action to button
                    SAlertDialog(isOpen: $showDeleteDialog) { openAction in
                        SButton("Delete Account", variant: .destructive) {
                            print("Delete Account button tapped, calling openAction")
                            openAction()
                        }
                    } content: {
                        VStack(alignment: .leading, spacing: 0) {
                            SAlertDialogParts.Title("Delete Account")
                            SAlertDialogParts.Description("Are you sure you want to delete your account? All of your data will be permanently removed. This action cannot be undone.")
                            
                            SAlertDialogParts.Footer {
                                SButton("Cancel", variant: .ghost) {
                                    print("Cancel delete button tapped")
                                    showDeleteDialog = false
                                }
                                
                                SButton("Delete", variant: .destructive) {
                                    print("Confirm delete button tapped")
                                    showDeleteDialog = false
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                print("Preview appeared")
            }
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
