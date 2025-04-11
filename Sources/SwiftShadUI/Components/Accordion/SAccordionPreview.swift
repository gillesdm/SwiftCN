// SAccordionPreview.swift (renamed from AccordionPreview.swift)
import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SAccordionPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.xl) {
            // Single type accordion
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Single Accordion")
                    .typography(.h3)
                
                SAccordion(type: .single, defaultOpenItems: ["item1"]) {
                    SAccordionItem(id: "item1", title: "What is SwiftShadUI?") {
                        Text("SwiftShadUI is a component library for SwiftUI inspired by shadcn/ui, providing customizable and accessible UI components.")
                            .typography(.base)
                    }
                    
                    SAccordionItem(id: "item2", title: "Is it customizable?") {
                        Text("Yes! SwiftShadUI is designed to be fully customizable. You can modify colors, typography, spacing, and more to match your app's design.")
                            .typography(.base)
                    }
                    
                    SAccordionItem(id: "item3", title: "How do I install it?", icon: Image(systemName: "questionmark.circle")) {
                        Text("Add SwiftShadUI to your project using Swift Package Manager by adding the repository URL to your project dependencies.")
                            .typography(.base)
                    }
                }
                .frame(maxWidth: 500)
            }
            
            // Multiple type accordion
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Multiple Accordion")
                    .typography(.h3)
                
                SAccordion(type: .multiple, defaultOpenItems: ["item1", "item3"]) {
                    SAccordionItem(id: "item1", title: "Section 1") {
                        VStack(alignment: .leading, spacing: Spacing.md) {
                            Text("This is the content for section 1.")
                                .typography(.base)
                            
                            SButton("Learn More", variant: .secondary) {
                                print("Button tapped")
                            }
                        }
                    }
                    
                    // Other items...
                }
                .frame(maxWidth: 500)
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
