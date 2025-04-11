import SwiftUI

/// An individual item within an SAccordion.
/// Styled to match shadcn/ui's minimalist design.
@available(iOS 15.0, macOS 12.0, *)
public struct SAccordionItem<Content: View>: View {
    @EnvironmentObject private var accordionState: AccordionState
    
    private let id: String
    private let title: String
    private let icon: Image?
    private let content: Content
    
    /// Creates a new AccordionItem.
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
            // Header - simplified to match shadcn/ui style
            Button {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                    accordionState.toggle(itemId: id)
                }
            } label: {
                HStack {
                    Text(title)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .foregroundColor(Colors.foreground)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
                        .foregroundColor(Colors.mutedForeground)
                        .rotationEffect(Angle(degrees: accordionState.isOpen(itemId: id) ? 180 : 0))
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 0)
                // Removed background color
                .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            
            // Thin divider
            Divider()
                .opacity(0.6)
            
            // Content
            if accordionState.isOpen(itemId: id) {
                content
                    .padding(.vertical, 16)
                    .padding(.horizontal, 0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(Text("\(accordionState.isOpen(itemId: id) ? "expanded" : "collapsed")"))
        .accessibilityHint(Text("Tap to \(accordionState.isOpen(itemId: id) ? "collapse" : "expand")"))
    }
}
