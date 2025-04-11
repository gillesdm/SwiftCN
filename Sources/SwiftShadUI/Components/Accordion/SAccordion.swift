import SwiftUI

/// A collapsible accordion component that displays a list of items that can be toggled to reveal/hide content.
/// Styled to match shadcn/ui's minimalist design.
@available(iOS 15.0, macOS 12.0, *)
public struct SAccordion<Content: View>: View {
    @StateObject private var accordionState: AccordionState
    private let content: Content
    
    /// Creates a new Accordion with the specified type and content.
    public init(
        type: AccordionType = .multiple,
        defaultOpenItems: [String] = [],
        @ViewBuilder content: () -> Content
    ) {
        self._accordionState = StateObject(wrappedValue: AccordionState(type: type, defaultOpenItems: defaultOpenItems))
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            content
                .environmentObject(accordionState)
        }
        // Remove border and rounded corners to match shadcn styling
    }
}
