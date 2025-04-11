import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SAccordionPreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            // Background that matches the app background
            Colors.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                // Title
                Text("Accordion Examples")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.foreground)
                
                // Single type accordion
                VStack(alignment: .leading, spacing: 0) {
                    SAccordion(type: .single) {
                        SAccordionItem(id: "item1", title: "Is it accessible?") {
                            Text("Yes. It adheres to the WAI-ARIA design pattern.")
                                .foregroundColor(Colors.mutedForeground)
                        }
                        
                        SAccordionItem(id: "item2", title: "Is it styled?") {
                            Text("Yes. It comes with default styles that match the other components and can be overridden with your own.")
                                .foregroundColor(Colors.mutedForeground)
                        }
                        
                        SAccordionItem(id: "item3", title: "Is it animated?") {
                            Text("Yes. It's animated by default, but you can disable it if you prefer.")
                                .foregroundColor(Colors.mutedForeground)
                        }
                    }
                    .frame(maxWidth: 500)
                }
                .padding(.horizontal, 24)
                .background(Colors.background)
                .cornerRadius(8)
                .padding(.horizontal)
            }
            .padding(.vertical, 40)
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
        
        // Also show in dark mode
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text("Accordion Examples")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.foreground)
                
                VStack(alignment: .leading, spacing: 0) {
                    SAccordion(type: .single) {
                        SAccordionItem(id: "item1", title: "Is it accessible?") {
                            Text("Yes. It adheres to the WAI-ARIA design pattern.")
                                .foregroundColor(Colors.mutedForeground)
                        }
                        
                        SAccordionItem(id: "item2", title: "Is it styled?") {
                            Text("Yes. It comes with default styles that match the other components and can be overridden with your own.")
                                .foregroundColor(Colors.mutedForeground)
                        }
                        
                        SAccordionItem(id: "item3", title: "Is it animated?") {
                            Text("Yes. It's animated by default, but you can disable it if you prefer.")
                                .foregroundColor(Colors.mutedForeground)
                        }
                    }
                    .frame(maxWidth: 500)
                }
                .padding(.horizontal, 24)
                .background(Colors.background)
                .cornerRadius(8)
                .padding(.horizontal)
            }
            .padding(.vertical, 40)
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
