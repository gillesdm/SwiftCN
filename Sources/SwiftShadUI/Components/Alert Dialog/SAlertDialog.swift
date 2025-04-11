import SwiftUI

/// Alert dialog controller that manages dialog state globally
@available(iOS 15.0, macOS 12.0, *)
public class AlertDialogController: ObservableObject {
    @Published public var isPresented: Bool = false
    @Published public var content: AnyView? = nil
    
    public static let shared = AlertDialogController()
    
    public func present<Content: View>(@ViewBuilder content: () -> Content) {
        self.content = AnyView(content())
        self.isPresented = true
    }
    
    public func dismiss() {
        self.isPresented = false
    }
}

/// A modal alert dialog component that renders a dialog overlay centered on the screen.
/// Can be used for confirmation dialogs, alerts, or other interactions that require user attention.
@available(iOS 15.0, macOS 12.0, *)
public struct SAlertDialog<TriggerContent: View, Content: View>: View {
    @StateObject private var controller = AlertDialogController.shared
    private var triggerContent: ((@escaping () -> Void)) -> TriggerContent
    private var dialogContent: () -> Content
    
    /// Creates a new alert dialog with a custom trigger and content
    /// - Parameters:
    ///   - triggerContent: Content that will trigger the dialog when tapped
    ///   - content: Content of the dialog
    public init(
        @ViewBuilder triggerContent: @escaping ((@escaping () -> Void)) -> TriggerContent,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.triggerContent = triggerContent
        self.dialogContent = content
    }
    
    public var body: some View {
        triggerContent {
            controller.present {
                dialogContent()
            }
        }
    }
}

/// View modifier to add alert dialog support to any view
@available(iOS 15.0, macOS 12.0, *)
public struct AlertDialogModifier: ViewModifier {
    @StateObject private var controller = AlertDialogController.shared
    @State private var animationState: AnimationState = .closed
    
    private enum AnimationState {
        case open
        case closed
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            // Main content
            content
            
            // Global overlay for the dialog
            if controller.isPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        closeDialog()
                    }
                    .transition(.opacity)
                
                if let dialogContent = controller.content {
                    dialogContent
                        .padding(Spacing.lg)
                        .background(Colors.background)
                        .cornerRadius(8)
                        .shadow(color: Colors.shadow, radius: 10, x: 0, y: 4)
                        .frame(maxWidth: 500)
                        .scaleEffect(animationState == .open ? 1 : 0.95)
                        .opacity(animationState == .open ? 1 : 0)
                        .onTapGesture { } // Prevent taps from reaching backdrop
                        .transition(.opacity)
                        .onAppear {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                animationState = .open
                            }
                        }
                        .handleEscapeKey {
                            closeDialog()
                        }
                }
            }
        }
        .onChange(of: controller.isPresented) { newValue in
            if !newValue {
                // Dialog was dismissed externally
                animationState = .closed
            }
        }
    }
    
    private func closeDialog() {
        withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
            animationState = .closed
        }
        
        // Slight delay to allow the animation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            controller.dismiss()
        }
    }
}

/// Pre-defined parts of the alert dialog
@available(iOS 15.0, macOS 12.0, *)
public struct SAlertDialogParts {
    /// The title of the alert dialog
    public struct Title<Content: View>: View {
        private let content: Content
        
        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        public init(_ title: String) where Content == Text {
            self.content = Text(title)
        }
        
        public var body: some View {
            content
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Colors.foreground)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, Spacing.xs)
                .accessibility(addTraits: .isHeader)
        }
    }
    
    /// The description text of the alert dialog
    public struct Description<Content: View>: View {
        private let content: Content
        
        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        public init(_ description: String) where Content == Text {
            self.content = Text(description)
        }
        
        public var body: some View {
            content
                .font(.system(size: 14))
                .foregroundColor(Colors.mutedForeground)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, Spacing.md)
        }
    }
    
    /// Container for the footer actions of the alert dialog
    public struct Footer<Content: View>: View {
        private let content: Content
        
        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        public var body: some View {
            HStack(spacing: Spacing.sm) {
                content
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, Spacing.md)
        }
    }
}

// Extension to make it easy to add alert dialog support to any view
@available(iOS 15.0, macOS 12.0, *)
public extension View {
    func withAlertDialogs() -> some View {
        self.modifier(AlertDialogModifier())
    }
}

// Platform-specific implementation for escape key handling
#if os(macOS)
// Use native onExitCommand on macOS
extension View {
    func handleEscapeKey(perform action: @escaping () -> Void) -> some View {
        return self.onExitCommand {
            action()
        }
    }
}
#else
// No-op on iOS and other platforms
extension View {
    func handleEscapeKey(perform action: @escaping () -> Void) -> Self {
        return self
    }
}
#endif
