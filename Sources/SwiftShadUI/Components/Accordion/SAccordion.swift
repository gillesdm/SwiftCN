import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
public struct SAccordion<Content: View>: View {
    @StateObject private var accordionState: AccordionState
    private let content: Content
    
    public init(
        type: AccordionType = .multiple,
        defaultOpenItems: [String] = [],
        @ViewBuilder content: () -> Content
    ) {
        self._accordionState = StateObject(wrappedValue: AccordionState(type: type, defaultOpenItems: defaultOpenItems))
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 1) {
            content
                .environmentObject(accordionState)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Colors.border, lineWidth: 1)
        )
    }
}
