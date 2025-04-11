import SwiftUI

public enum AccordionType {
    case single
    case multiple
}

@available(iOS 15.0, macOS 12.0, *)
public class AccordionState: ObservableObject {
    @Published public var openItems: Set<String> = []
    
    public let type: AccordionType
    
    public init(type: AccordionType = .multiple, defaultOpenItems: [String] = []) {
        self.type = type
        self.openItems = Set(defaultOpenItems)
    }
    
    public func toggle(itemId: String) {
        if openItems.contains(itemId) {
            openItems.remove(itemId)
        } else {
            if type == .single {
                openItems.removeAll()
            }
            openItems.insert(itemId)
        }
    }
    
    public func isOpen(itemId: String) -> Bool {
        openItems.contains(itemId)
    }
}
