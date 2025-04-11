import SwiftUI

/// A modal alert dialog component that renders a dialog overlay centered on the screen.
/// Can be used for confirmation dialogs, alerts, or other interactions that require user attention.
@available(iOS 15.0, macOS 12.0, *)
public struct SAlertDialog<TriggerContent: View, Content: View>: View {
    @Binding private var isOpen: Bool
    private let triggerContent: TriggerContent
    private let content: Content
    
    @State private var animationState: AnimationState = .closed
    
    private enum AnimationState {
        case open
        case closed
    }
    
    /// Creates a new alert dialog with a custom trigger and content
    /// - Parameters:
    ///   - isOpen: Binding that controls whether the dialog is shown
    ///   - triggerContent: Content that will trigger the dialog when tapped
    ///   - content: Content of the dialog
    public init(
        isOpen: Binding<Bool>,
        @ViewBuilder triggerContent: () -> TriggerContent,
        @ViewBuilder content: () -> Content
    ) {
        self._isOpen = isOpen
        self.triggerContent = triggerContent()
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            // Trigger
            triggerContent
                .onTapGesture {
                    openDialog()
                }
            
            // Dialog overlay (only shown when isOpen is true)
            if isOpen {
                GeometryReader { geometry in
                    ZStack {
                        // Backdrop
                        Colors.overlay
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                closeDialog()
                            }
                        
                        // Dialog content
                        content
                            .padding(Spacing.lg)
                            .background(Colors.background)
                            .cornerRadius(8)
                            .shadow(color: Colors.shadow, radius: 10, x: 0, y: 4)
                            .frame(maxWidth: min(geometry.size.width * 0.9, 500))
                            .scaleEffect(animationState == .open ? 1 : 0.95)
                            .opacity(animationState == .open ? 1 : 0)
                    }
                }
                .transition(.opacity)
                .zIndex(999)
                .onAppear {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        animationState = .open
                    }
                }
                .onDisappear {
                    animationState = .closed
                }
                .onExitCommand { // For macOS escape key
                    closeDialog()
                }
                #if os(iOS)
                .gesture(
                    DragGesture()
                        .onEnded { _ in
                            // Allow swiping to dismiss on iOS
                            closeDialog()
                        }
                )
                #endif
            }
        }
    }
    
    private func openDialog() {
        isOpen = true
    }
    
    private func closeDialog() {
        withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
            animationState = .closed
        }
        
        // Slight delay to allow the animation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isOpen = false
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

#if os(macOS)
extension View {
    func onExitCommand(perform action: @escaping () -> Void) -> some View {
        self.onExitCommand {
            action()
        }
    }
}
#else
extension View {
    func onExitCommand(perform action: @escaping () -> Void) -> some View {
        self
    }
}
#endif
