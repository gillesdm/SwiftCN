
# SwiftCN: Where shadcn/ui meets SwiftUI in a beautiful, customizable design system

🪄 **The Magic of shadcn/ui, Now in SwiftUI!**
SwiftCN brings the elegant, customizable design philosophy of shadcn/ui to the SwiftUI ecosystem. Not a rigid component library, but a collection of reusable components you can copy, paste, and customize to your heart's content!
Built on a solid foundation of design tokens and best practices, SwiftCN gives you the building blocks for creating beautiful, accessible, and consistent UIs without sacrificing flexibility.

## ✨ Features
-  🧩 **Modular Components:** Use what you need, leave what you don't
-  🎨 **Beautiful Slate Theme:** Sophisticated color palette with dark mode support
-  ♿ **Accessibility First:** Designed with a11y in mind
-  🧪 **Swift Package Manager:** Easy to integrate into your projects
-  💪 **SwiftUI Native:** Built for SwiftUI, by SwiftUI enthusiasts
-  🎯 **iOS 15+ & macOS 12+:** Targeting modern Apple platforms
-  🛠️ **Fully Customizable:** Tweak and adapt to fit your needs

## 📦 Installation
### Swift Package Manager
Add SwiftCN to your project through Xcode:
1. Go to **File > Add Packages...**
2. Enter the repository URL: `https://github.com/gillesdm/SwiftCN.git`
3. Choose the version rule (recommended: **Up to Next Major**)
4. Click **Add Package**

Or add it directly to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/gillesdm/SwiftCN.git", from: "0.1.0")
]

🚀 Quick Start

import SwiftUI
import SwiftCN

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to SwiftCN!")
                .typography(.h2)
            
            Button("Get Started", size: .lg, fullWidth: true) {
                print("Let's go!")
            }
            
            Button("Learn More",
                   variant: .outline,
                   icon: Image(systemName: "book.fill"),
                   action: {
                print("Opening docs...")
            })
            
            Button("Cancel",
                   variant: .ghost,
                   size: .sm,
                   action: {
                print("Cancelled")
            })
        }
        .padding()
    }
}
```

## 🧩 Components
### Button
The Button component is the cornerstone of user interaction in any app. SwiftCN's button is highly customizable with various styles, sizes, and states.

#### Variants

```swift
// Primary button (default)
Button("Primary Button") {
    // Action here
}

// Secondary button
Button("Secondary Button", variant: .secondary) {
    // Action here
}

// Outline button
Button("Outline Button", variant: .outline) {
    // Action here
}

// Ghost button
Button("Ghost Button", variant: .ghost) {
    // Action here
}

// Link button
Button("Link Button", variant: .link) {
    // Action here
}

// Destructive button
Button("Delete", variant: .destructive) {
    // Careful now!
}
```

##### Sizes

```swift
Button("Small", size: .sm) {}
Button("Medium", size: .md) {} // Default
Button("Large", size: .lg) {}
```

##### Icons

```swift
// Leading icon (default)
Button("With Icon",
       icon: Image(systemName: "star.fill")) {
    // Action
}

// Trailing icon
Button("Next",
       icon: Image(systemName: "arrow.right"),
       iconPosition: .trailing) {
    // Action
}
```

##### Full Width & Disabled States

```swift
// Full width button
Button("Submit", fullWidth: true) {
    // Action
}

// Disabled button
Button("Not Available", isEnabled: false) {
    // This action won't trigger
}
```

## 🎨 Customization
### Theming
SwiftCN is built on a token-based design system, making it incredibly customizable:

```swift
// Use the default slate theme
// Or customize with your own colors in Assets.xcassets
```

### Design Tokens

```swift
// Typography
Text("Heading").typography(.h1)
Text("Body text").typography(.base)

// Spacing
.padding(Spacing.md)
.padding(.horizontal, Spacing.lg)
```

## 📱 Examples
### Sign-Up Form

```swift
VStack(spacing: Spacing.lg) {
    Text("Create an Account")
        .typography(.h2)

    // Form fields would go here

    Button("Sign Up", fullWidth: true) {
        // Handle sign up
    }

    Button("Already have an account?",
           variant: .link) {
        // Navigate to login
    }
}
.padding()
```

### Action Sheet

```swift
VStack(spacing: Spacing.md) {
    Button("Save Changes", fullWidth: true) {
        // Save action
    }

    Button("Discard",
           variant: .outline,
           fullWidth: true) {
        // Discard action
    }

    Button("Cancel",
           variant: .ghost,
           fullWidth: true) {
        // Cancel action
    }
}
.padding()
```

## 🗺️ Roadmap
SwiftCN is just getting started! Here's what's coming:
- [ ] More base components (Card, Input, Checkbox, Toggle)
- [ ] Compound components (Form, Dialog, Dropdown)
- [ ] Animation and transition presets
- [ ] More themes beyond Slate
- [ ] SwiftUI Previews Catalog
- [ ] Documentation site with examples
- [ ] iOS and macOS example apps

## 🤝 Contributing
We'd love your help making SwiftCN even better!
1. Fork the repository
2. Create a new branch (`git checkout -b feature/amazing-component`)
3. Make your changes
4. Run tests (`swift test`)
5. Commit your changes (`git commit -m 'Add amazing component'`)
6. Push to the branch (`git push origin feature/amazing-component`)
7. Open a Pull Request

### Development Guidelines
- Follow Swift style guidelines
- Include previews for visual components
- Write tests for new functionality
- Update documentation with new components

## 📄 License
SwiftCN is available under the MIT license. See the `LICENSE` file for more information.

## 💖 Acknowledgments
- Inspired by [shadcn/ui](https://ui.shadcn.com/)
- Built with SwiftUI
- Thanks to the open-source community

> 🧙‍♂️ "Great UIs are indistinguishable from magic. SwiftCN is your spellbook."

*This README is as customizable as the library itself! Feel free to adapt it to your needs.*




