import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SAvatarPreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 40) {
                    Text("Avatar Examples")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Colors.foreground)
                    
                    Group {
                        // Avatar with image
                        VStack(spacing: 16) {
                            Text("With Image")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(
                                    image: Image("avatar-placeholder"),
                                    initials: "JD"
                                )
                                
                                SAvatar(
                                    image: Image("avatar-placeholder"),
                                    initials: "JD",
                                    status: .online
                                )
                            }
                        }
                        
                        // Fallback with initials
                        VStack(spacing: 16) {
                            Text("With Initials")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(initials: "JD")
                                
                                SAvatar(
                                    initials: "AB",
                                    status: .offline
                                )
                            }
                        }
                        
                        // Icon fallback
                        VStack(spacing: 16) {
                            Text("With Icon")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(systemName: "person.fill")
                                
                                SAvatar(
                                    systemName: "person.crop.circle",
                                    status: .away
                                )
                            }
                        }
                        
                        // Different sizes
                        VStack(spacing: 16) {
                            Text("Sizes")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(initials: "XS", size: .xs)
                                SAvatar(initials: "SM", size: .sm)
                                SAvatar(initials: "MD", size: .md) // default
                                SAvatar(initials: "LG", size: .lg)
                                SAvatar(initials: "XL", size: .xl)
                            }
                        }
                        
                        // Different shapes
                        VStack(spacing: 16) {
                            Text("Shapes")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(
                                    initials: "C",
                                    shape: .circle // default
                                )
                                
                                SAvatar(
                                    initials: "S",
                                    shape: .square
                                )
                                
                                SAvatar(
                                    initials: "R",
                                    shape: .rounded
                                )
                            }
                        }
                        
                        // Status indicators
                        VStack(spacing: 16) {
                            Text("Status")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(
                                    initials: "ON",
                                    status: .online
                                )
                                
                                SAvatar(
                                    initials: "OF",
                                    status: .offline
                                )
                                
                                SAvatar(
                                    initials: "AW",
                                    status: .away
                                )
                                
                                SAvatar(
                                    initials: "BU",
                                    status: .busy
                                )
                            }
                        }
                        
                        // Custom fallback
                        VStack(spacing: 16) {
                            Text("Custom Fallback")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(fallbackView: {
                                    VStack {
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.blue)
                                        Text("?")
                                            .font(.caption)
                                    }
                                })
                            }
                        }
                        
                        // New URL testing section
                        VStack(spacing: 16) {
                            Text("URL Testing")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            // Test with GitHub avatar
                            SAvatar.testUrl(
                                "https://github.com/octocat.png",
                                fallbackInitials: "OC"
                            )
                            
                            // Test with a placeholder image service
                            SAvatar.testUrl(
                                "https://via.placeholder.com/150",
                                fallbackInitials: "PH"
                            )
                            
                            // Test with another placeholder service
                            SAvatar.testUrl(
                                "https://picsum.photos/200",
                                fallbackInitials: "PS"
                            )
                            
                            // Test with secure HTTPS image that should be accessible
                            SAvatar.testUrl(
                                "https://avatars.githubusercontent.com/u/583231?v=4",
                                fallbackInitials: "GH"
                            )
                        }
                    }
                }
                .padding()
            }
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
        
        // Dark mode preview
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 40) {
                    Text("Avatar Examples")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Colors.foreground)
                    
                    Group {
                        // Avatar with image
                        VStack(spacing: 16) {
                            Text("With Image")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(
                                    image: Image("avatar-placeholder"),
                                    initials: "JD"
                                )
                            }
                        }
                        
                        // Different sizes
                        VStack(spacing: 16) {
                            Text("Sizes")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            HStack(spacing: 20) {
                                SAvatar(initials: "XS", size: .xs)
                                SAvatar(initials: "SM", size: .sm)
                                SAvatar(initials: "MD", size: .md) // default
                                SAvatar(initials: "LG", size: .lg)
                                SAvatar(initials: "XL", size: .xl)
                            }
                        }
                        
                        // URL Testing in Dark Mode
                        VStack(spacing: 16) {
                            Text("URL Testing")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Colors.foreground)
                            
                            // Test with GitHub avatar
                            SAvatar.testUrl(
                                "https://github.com/octocat.png",
                                fallbackInitials: "OC"
                            )
                        }
                    }
                }
                .padding()
            }
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
