import SwiftUI

/// A modal alert dialog component that renders a dialog overlay centered on the screen.
/// Can be used for confirmation dialogs, alerts, or other interactions that require user attention.
@available(iOS 15.0, macOS 12.0, *)
public struct SAlertDialog<TriggerContent: View, Content: View>: View {
    @Binding private var isOpen: Bool
    private let triggerContent: ((@escaping () -> Void)) -> TriggerContent
    private let content: Content
    
    @State private var animationState: AnimationState = .closed
    
    private enum AnimationState {
        case open
        case closed
    }
    
    /// Creates a new alert dialog with a custom trigger and content
    /// - Parameters:
    ///   - isOpen: Binding that controls whether the dialog is shown
    ///   - triggerContent: Content that will trigger the dialog when tapped, receives openDialog action
    ///   - content: Content of the dialog
    public init(
        isOpen: Binding<Bool>,
        @ViewBuilder triggerContent: @escaping ((@escaping () -> Void)) -> TriggerContent,
        @ViewBuilder content: () -> Content
    ) {
        self._isOpen = isOpen
        self.triggerContent = triggerContent
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            // Trigger with explicit open action passed to it
            triggerContent({
                print("Dialog trigger tapped") // Logging
                openDialog()
            })
            
            // Dialog overlay (only shown when isOpen is true)
            if isOpen {
                GeometryReader { geometry in
                    ZStack {
                        // Backdrop
                        Colors.overlay
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                print("Backdrop tapped") // Logging
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
                            .onTapGesture { } // Prevent taps from reaching backdrop
                    }
                }
                .transition(.opacity)
                .zIndex(999)
                .onAppear {
                    print("Dialog appeared") // Logging
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        animationState = .open
                    }
                }
                .onDisappear {
                    print("Dialog disappeared") // Logging
                    animationState = .closed
                }
                .handleEscapeKey {
                    print("Escape key pressed") // Logging
                    closeDialog()
                }
                #if os(iOS)
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onEnded { _ in
                            print("Drag gesture detected") // Logging
                            closeDialog()
                        }
                )
                #endif
            }
        }
    }
    
    private func openDialog() {
        print("openDialog() called, setting isOpen to true") // Logging
        isOpen = true
    }
    
    private func closeDialog() {
        print("closeDialog() called") // Logging
        withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
            animationState = .closed
        }
        
        // Slight delay to allow the animation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            print("Dialog closing after animation") // Logging
            isOpen = false
        }
    }
}

// Rest of the file remains the same
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
