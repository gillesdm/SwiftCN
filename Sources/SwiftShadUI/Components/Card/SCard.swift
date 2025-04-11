import SwiftUI

/// A container component styled as a card, used to group related content.
/// Inspired by shadcn/ui, it supports structured content via Header, Title, Description, Content, and Footer parts.
@available(iOS 15.0, macOS 12.0, *)
public struct SCard<Content: View>: View {
    private let content: Content

    /// Creates a new card container.
    /// - Parameter content: The content to display inside the card, typically composed using SCard parts.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) { // Use spacing: 0; internal parts manage their own padding
            content
        }
        .background(Colors.card) // Use the specific card background color
        .cornerRadius(8) // Standard corner radius
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Colors.border, lineWidth: 1) // Subtle border
        )
        .shadow(color: Colors.shadowLight, radius: 1, x: 0, y: 1) // Subtle shadow
    }
}

// MARK: - Card Parts

/// Pre-defined parts for structuring content within an SCard.
@available(iOS 15.0, macOS 12.0, *)
public struct SCardParts {

    /// Container for the card's header section. Typically contains Title and Description.
    public struct Header<Content: View>: View {
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        public var body: some View {
            VStack(alignment: .leading, spacing: Spacing.xxs) { // Reduced spacing within header
                content
            }
            .padding(Spacing.lg) // Standard padding for the header section
        }
    }

    /// View for displaying the main title within the Card Header.
    public struct Title<Content: View>: View {
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        /// Convenience initializer for simple text title.
        public init(_ title: String) where Content == Text {
            self.content = Text(title)
        }

        public var body: some View {
            content
                .font(.system(size: 18, weight: .semibold)) // Title font style
                .foregroundColor(Colors.cardForeground)
                .accessibilityAddTraits(.isHeader)
        }
    }

    /// View for displaying description text within the Card Header.
    public struct Description<Content: View>: View {
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        /// Convenience initializer for simple text description.
        public init(_ description: String) where Content == Text {
            self.content = Text(description)
        }

        public var body: some View {
            content
                .font(.system(size: 14)) // Description font style
                .foregroundColor(Colors.mutedForeground) // Muted color for description
        }
    }

    /// Container for the main content area of the card.
    public struct Content<Content: View>: View {
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        public var body: some View {
            content
                // Apply padding, ensuring it doesn't double-pad if Header/Footer aren't present
                // A simple approach is consistent padding, users can adjust if needed.
                .padding(Spacing.lg)
        }
    }

    /// Container for the card's footer section. Typically contains actions or summary information.
    public struct Footer<Content: View>: View {
        private let content: Content

        public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        public var body: some View {
            content
                .padding(Spacing.lg) // Standard padding for the footer section
        }
    }
}
