import SwiftUI

/// An individual item within an Accordion.
///
/// Each AccordionItem has a header that can be clicked to toggle visibility of its content.
///
@available(iOS 15.0, macOS 12.0, *)
public struct SAccordionItem<Content: View>: View {
    @EnvironmentObject private var accordionState: AccordionState
    
    private let id: String
    private let title: String
    private let icon: Image?
    private let content: Content
    
    @State private var contentHeight: CGFloat = 0
    @State private var isHovered: Bool = false
    
    /// Creates a new AccordionItem.
    /// - Parameters:
    ///   - id: Unique identifier for this item
    ///   - title: Title displayed in the header
    ///   - icon: Optional icon to display before the title
    ///   - content: Content to display when the item is expanded
    public init(
        id: String,
        title: String,
        icon: Image? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.id = id
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Header - using our custom SButton instead of SwiftUI Button
            SButton(title,
                   variant: .ghost,
                   fullWidth: true,
                   icon: icon,
                   action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    accordionState.toggle(itemId: id)
                }
            })
            .overlay(alignment: .trailing) {
                // Add chevron icon
                Image(systemName: "chevron.down")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Colors.mutedForeground)
                    .rotationEffect(Angle(degrees: accordionState.isOpen(itemId: id) ? 180 : 0))
                    .padding(.trailing, Spacing.md)
            }
            
            // Content
            if accordionState.isOpen(itemId: id) {
                Divider()
                
                content
                    .padding(Spacing.md)
                    .background(Colors.background)
                    .frame(maxWidth: .infinity)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(Text("\(accordionState.isOpen(itemId: id) ? "expanded" : "collapsed")"))
        .accessibilityHint(Text("Tap to \(accordionState.isOpen(itemId: id) ? "collapse" : "expand")"))
    }

}

// The onHover modifier is only available on macOS
#if os(macOS)
extension View {
    func onHover(_ perform: @escaping (Bool) -> Void) -> some View {
        self.onHover(perform: perform)
    }
}
#else
extension View {
    func onHover(_ perform: @escaping (Bool) -> Void) -> some View {
        self
    }
}
#endif
