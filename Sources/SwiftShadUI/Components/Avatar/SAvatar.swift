import SwiftUI

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// A component that displays a user's profile picture, initials, or a fallback icon.
@available(iOS 15.0, macOS 12.0, *)
public struct SAvatar: View {
    // MARK: - Types
    
    /// Size options for the avatar
    public enum Size {
        case xs, sm, md, lg, xl
        
        var dimension: CGFloat {
            switch self {
            case .xs: return 24
            case .sm: return 32
            case .md: return 40
            case .lg: return 56
            case .xl: return 80
            }
        }
        
        var fontSize: CGFloat {
            return dimension * 0.4
        }
    }
    
    /// Shape options for the avatar
    public enum Shape {
        case circle, square, rounded
        
        func cornerRadius(for size: Size) -> CGFloat {
            switch self {
            case .circle: return size.dimension / 2
            case .square: return 0
            case .rounded: return size.dimension / 8
            }
        }
    }
    
    /// Status indicator options
    public enum Status {
        case online, offline, away, busy
        
        var color: Color {
            switch self {
            case .online: return Colors.success
            case .offline: return Colors.mutedForeground
            case .away: return Colors.warning
            case .busy: return Colors.destructive
            }
        }
    }
    
    /// The type of fallback content to display
    private enum FallbackType {
        case initials(String)
        case icon(Image)
        case custom(AnyView)
    }
    
    // MARK: - Properties
    
    private let image: Image? // Holds an already loaded image, nil if using URL or only fallback
    private let fallbackType: FallbackType
    private let size: Size
    private let shape: Shape
    private let status: Status?
    
    // MARK: - Initializers
    
    /// Creates an avatar with an optional image and initials fallback
    public init(
        image: Image? = nil,
        initials: String,
        size: Size = .md,
        shape: Shape = .circle,
        status: Status? = nil
    ) {
        self.image = image
        self.fallbackType = .initials(initials)
        self.size = size
        self.shape = shape
        self.status = status
    }
    
    /// Creates an avatar with an optional image and icon fallback
    public init(
        image: Image? = nil,
        systemName: String,
        size: Size = .md,
        shape: Shape = .circle,
        status: Status? = nil
    ) {
        self.image = image
        self.fallbackType = .icon(Image(systemName: systemName))
        self.size = size
        self.shape = shape
        self.status = status
    }
    
    /// Creates an avatar with an optional image and a custom fallback view
    public init<V: View>(
        image: Image? = nil,
        fallbackView: @escaping () -> V,
        size: Size = .md,
        shape: Shape = .circle,
        status: Status? = nil
    ) {
        self.image = image
        self.fallbackType = .custom(AnyView(fallbackView()))
        self.size = size
        self.shape = shape
        self.status = status
    }
    
    // Private initializer used by URL loading methods
    private init(
        _ image: Image? = nil, // Underscore to avoid conflict
        _ fallbackType: FallbackType,
        size: Size = .md,
        shape: Shape = .circle,
        status: Status? = nil
    ) {
        self.image = image
        self.fallbackType = fallbackType
        self.size = size
        self.shape = shape
        self.status = status
    }
    
    // MARK: - View Body
    
    public var body: some View {
        ZStack {
            // Avatar content container
            Group {
                if let image = image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    fallbackView
                }
            }
            .frame(width: size.dimension, height: size.dimension)
            .clipShape(RoundedRectangle(cornerRadius: shape.cornerRadius(for: size)))
            .background(
                RoundedRectangle(cornerRadius: shape.cornerRadius(for: size))
                    .fill(Colors.muted) // Background for fallback
            )
            
            // Status indicator overlay
            if let status = status {
                Circle()
                    .fill(status.color)
                    .frame(width: size.dimension / 6, height: size.dimension / 6)
                    .overlay(
                        Circle()
                            .stroke(Colors.background, lineWidth: 1.5) // Border around status
                    )
                    .position(x: size.dimension - (size.dimension / 12),
                              y: size.dimension - (size.dimension / 12))
            }
        }
        .frame(width: size.dimension, height: size.dimension) // Overall frame
    }
    
    /// Internal view builder for fallback content
    @ViewBuilder
    private var fallbackView: some View {
        switch fallbackType {
        case .initials(let text):
            Text(text)
                .font(.system(size: size.fontSize, weight: .medium))
                .foregroundColor(Colors.foreground)
                .frame(width: size.dimension, height: size.dimension) // Ensure fallback fills frame
                .contentShape(Rectangle()) // Make sure background is applied correctly
                
        case .icon(let icon):
            icon
                .font(.system(size: size.fontSize))
                .foregroundColor(Colors.foreground)
                .frame(width: size.dimension, height: size.dimension)
                .contentShape(Rectangle())
                
        case .custom(let view):
            view
                .frame(width: size.dimension, height: size.dimension)
                .contentShape(Rectangle())
        }
    }
}

// MARK: - Convenience extensions with debugging

@available(iOS 15.0, macOS 12.0, *)
public extension SAvatar {
    /// Creates an avatar view that loads an image from a URL
    static func url(
        _ url: URL?,
        fallbackInitials: String,
        size: Size = .md,
        shape: Shape = .circle,
        status: Status? = nil
    ) -> some View {
        // Directly use AsyncImage here, returning the appropriate SAvatar view
        AsyncImage(url: url, scale: 1.0) { phase in
            switch phase {
            case .success(let image):
                SAvatar(image: image, initials: fallbackInitials, size: size, shape: shape, status: status)
            case .failure(let error):
                SAvatar(initials: fallbackInitials, size: size, shape: shape, status: status)
                    .overlay(
                        RoundedRectangle(cornerRadius: shape.cornerRadius(for: size))
                            .stroke(Color.red, lineWidth: 2)
                    )
            case .empty:
                ZStack {
                    SAvatar(initials: fallbackInitials, size: size, shape: shape, status: status)
                        .opacity(0.5)
                    ProgressView().progressViewStyle(.circular)
                }
            @unknown default:
                SAvatar(initials: fallbackInitials, size: size, shape: shape, status: status)
            }
        }
        .id(url) // Add id to help SwiftUI manage updates
    }
    
    /// Alternative URL loading method with explicit scale parameter
    static func urlWithScale(
        _ url: URL?,
        fallbackInitials: String,
        scale: CGFloat = 1.0,
        size: Size = .md,
        shape: Shape = .circle,
        status: Status? = nil
    ) -> some View {
        AsyncImage(url: url, scale: scale) { phase in
            switch phase {
            case .success(let image):
                 SAvatar(image: image, initials: fallbackInitials, size: size, shape: shape, status: status)
            case .failure(let error):
                SAvatar(initials: fallbackInitials, size: size, shape: shape, status: status)
                    .overlay(
                        RoundedRectangle(cornerRadius: shape.cornerRadius(for: size))
                            .stroke(Color.red, lineWidth: 2)
                    )
            case .empty:
                 ZStack {
                    SAvatar(initials: fallbackInitials, size: size, shape: shape, status: status)
                        .opacity(0.5)
                    ProgressView().progressViewStyle(.circular)
                }
            @unknown default:
                 SAvatar(initials: fallbackInitials, size: size, shape: shape, status: status)
            }
        }
        .id(url) // Add id
    }
    
    /// Method for testing with various URL loading approaches
    static func testUrl(
        _ urlString: String,
        fallbackInitials: String,
        size: Size = .md
    ) -> some View {
        VStack(spacing: 20) {
            Text("Testing URL loading for:")
                .font(.headline)
            
            Text(urlString)
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let url = URL(string: urlString) {
                HStack(spacing: 20) {
                    // Method 1: Standard AsyncImage
                    VStack {
                        // Corrected call
                        SAvatar.url(url, fallbackInitials: fallbackInitials, size: size)
                        Text("Standard")
                            .font(.caption)
                    }
                    
                    // Method 2: With scale parameter
                    VStack {
                        SAvatar.urlWithScale(url, fallbackInitials: fallbackInitials, scale: 2.0, size: size)
                        Text("Scale 2.0")
                            .font(.caption)
                    }
                    
                    // Method 3: With URLSession
                    URLSessionAvatarImage(url: url, fallbackInitials: fallbackInitials, size: size)
                }
            } else {
                Text("Invalid URL")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Colors.background)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

/// Alternative avatar image loader using URLSession instead of AsyncImage
@available(iOS 15.0, macOS 12.0, *)
public struct URLSessionAvatarImage: View {
    let url: URL
    let fallbackInitials: String
    let size: SAvatar.Size
    let shape: SAvatar.Shape = .circle // Default shape
    let status: SAvatar.Status? = nil // Default status

    #if os(iOS)
    @State private var image: UIImage?
    #elseif os(macOS)
    @State private var image: NSImage?
    #endif
    
    @State private var isLoading = true
    @State private var error: Error?
    
    public var body: some View {
        VStack(spacing: 4) { // Added spacing
            // Determine the platform-specific Image if loaded
            #if os(iOS)
            let platformImage = image.map { Image(uiImage: $0) }
            #elseif os(macOS)
            let platformImage = image.map { Image(nsImage: $0) }
            #endif

            // Conditionally display loading, error, or loaded image
            Group {
                if isLoading {
                    ZStack {
                        SAvatar(initials: fallbackInitials, size: size, shape: shape, status: status)
                            .opacity(0.5)
                        ProgressView().progressViewStyle(.circular)
                    }
                } else if error != nil {
                     SAvatar(initials: fallbackInitials, size: size, shape: shape, status: status)
                        .overlay(
                            RoundedRectangle(cornerRadius: shape.cornerRadius(for: size))
                                .stroke(Color.red, lineWidth: 2)
                        )
                } else {
                    // Display the avatar with the loaded image
                    SAvatar(image: platformImage, initials: fallbackInitials, size: size, shape: shape, status: status)
                }
            }
            .onAppear {
                // Load image only if it hasn't been loaded and isn't currently erroring
                if image == nil && error == nil {
                    loadImage()
                }
            }
            
            Text("URLSession")
                .font(.caption)
            
            if let error = error {
                Text(error.localizedDescription)
                    .font(.caption2)
                    .foregroundColor(.red)
                    .lineLimit(1)
                    .frame(maxWidth: 100)
            }
        } // End of VStack
    }
    
    private func loadImage() {
        isLoading = true
        error = nil // Reset error on new load attempt
        
        URLSession.shared.dataTask(with: url) { data, response, taskError in
            DispatchQueue.main.async {
                isLoading = false // Set loading to false once task completes
                
                if let taskError = taskError {
                    self.error = taskError
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    self.error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Status: \(httpResponse.statusCode)"])
                    return
                }
                
                guard let data = data else {
                    self.error = NSError(domain: "Data Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    return
                }
                                
                #if os(iOS)
                if let loadedImage = UIImage(data: data) {
                    self.image = loadedImage
                } else {
                    self.error = NSError(domain: "Image Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])
                }
                #elseif os(macOS)
                if let loadedImage = NSImage(data: data) {
                    self.image = loadedImage
                } else {
                    self.error = NSError(domain: "Image Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])
                }
                #endif
            }
        }.resume()
    }
}
