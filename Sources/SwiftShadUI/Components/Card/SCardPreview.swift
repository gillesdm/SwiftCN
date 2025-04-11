import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SCardPreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all) // Use app background

            ScrollView {
                VStack(spacing: Spacing.xl) {
                    Text("Card Examples")
                       .font(.system(size: 24, weight: .bold))
                       .foregroundColor(Colors.foreground)

                    // Example 1: Full Card Structure
                    SCard {
                        SCardParts.Header {
                            SCardParts.Title("Card Title")
                            SCardParts.Description("Brief description about the card content.")
                        }
                        SCardParts.Content {
                            Text("This is the main content area of the card. You can place any SwiftUI view here.")
                                .foregroundColor(Colors.cardForeground)
                        }
                        Divider().padding(.horizontal, Spacing.lg) // Optional divider
                        SCardParts.Footer {
                            HStack {
                                SButton("Cancel", variant: .outline) {}
                                Spacer()
                                SButton("Confirm") {}
                            }
                        }
                    }
                    .frame(maxWidth: 400)

                    // Example 2: Card with only Content
                    SCard {
                        SCardParts.Content {
                            Text("This card only has content, demonstrating flexibility.")
                                .foregroundColor(Colors.cardForeground)
                                .padding(.vertical, Spacing.lg) // Add extra padding if needed
                        }
                    }
                    .frame(maxWidth: 400)

                    // Example 3: Card with Header and Footer
                     SCard {
                        SCardParts.Header {
                            SCardParts.Title("Notifications")
                            SCardParts.Description("Manage your notification settings.")
                        }
                         // No explicit Content part, Footer directly follows Header
                        SCardParts.Footer {
                            HStack {
                                Text("Enable Notifications").foregroundColor(Colors.cardForeground)
                                Spacer()
                                // Placeholder for a Toggle component
                                Circle().fill(Colors.primary).frame(width: 30, height: 30)
                            }
                        }
                    }
                    .frame(maxWidth: 400)
                    
                    // Example 4: Card with Header and Content (No Footer)
                    SCard {
                       SCardParts.Header {
                           SCardParts.Title("User Profile")
                       }
                       SCardParts.Content {
                            HStack(spacing: Spacing.md) {
                                SAvatar(initials: "AB", size: .lg)
                                VStack(alignment: .leading) {
                                    Text("Anne Baxter").foregroundColor(Colors.cardForeground).fontWeight(.medium)
                                    Text("anne.baxter@example.com").foregroundColor(Colors.mutedForeground)
                                }
                                Spacer()
                                SButton("Edit", variant: .secondary, size: .sm) {}
                            }
                       }
                   }
                   .frame(maxWidth: 400)


                }
                .padding() // Padding for the VStack containing cards
            }
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Light Mode")
        .preferredColorScheme(.light)
        
        // Dark mode preview
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all) // Use app background

            ScrollView {
                VStack(spacing: Spacing.xl) {
                     Text("Card Examples (Dark)")
                       .font(.system(size: 24, weight: .bold))
                       .foregroundColor(Colors.foreground)
                    
                    // Example 1: Full Card Structure
                    SCard {
                        SCardParts.Header {
                            SCardParts.Title("Card Title (Dark)")
                            SCardParts.Description("Brief description about the card content.")
                        }
                        SCardParts.Content {
                            Text("This is the main content area of the card.")
                                .foregroundColor(Colors.cardForeground)
                        }
                        SCardParts.Footer {
                            HStack {
                                Spacer()
                                SButton("Action") {}
                            }
                        }
                    }
                    .frame(maxWidth: 400)
                }
                .padding()
            }
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Dark Mode")
        .preferredColorScheme(.dark)
    }
}
