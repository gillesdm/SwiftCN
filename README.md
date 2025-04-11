
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
2. Enter the repository URL: `https://github.com/gillesdm/SwiftCN.git` (Note: Update this URL if it changes)
3. Choose the version rule (recommended: **Up to Next Major**)
4. Click **Add Package**

Or add it directly to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/gillesdm/SwiftCN.git", from: "0.1.0") // Note: Update this URL if it changes
]
```

## 🚀 Quick Start
```swift
import SwiftUI
import SwiftCN

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to SwiftCN!")
                .typography(.h2)

            SButton("Get Started", size: .lg, fullWidth: true) {
                print("Let's go!")
            }

            SButton("Learn More",
                   variant: .outline,
                   icon: Image(systemName: "book.fill"),
                   action: {
                print("Opening docs...")
            })

            SButton("Cancel",
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

### SButton
The SButton component is the cornerstone of user interaction in any app. SwiftCN's button is highly customizable with various styles, sizes, and states.

<details>
<summary>More about the SButton</summary>

#### Variants

```swift
// Primary button (default)
SButton("Primary Button") {
    // Action here
}

// Secondary button
SButton("Secondary Button", variant: .secondary) {
    // Action here
}

// Outline button
SButton("Outline Button", variant: .outline) {
    // Action here
}

// Ghost button
SButton("Ghost Button", variant: .ghost) {
    // Action here
}

// Link button
SButton("Link Button", variant: .link) {
    // Action here
}

// Destructive button
SButton("Delete", variant: .destructive) {
    // Careful now!
}
```

##### Sizes

```swift
SButton("Small", size: .sm) {}
SButton("Medium", size: .md) {} // Default
SButton("Large", size: .lg) {}
```

##### Icons

```swift
// Leading icon (default)
SButton("With Icon",
       icon: Image(systemName: "star.fill")) {
    // Action
}

// Trailing icon
SButton("Next",
       icon: Image(systemName: "arrow.right"),
       iconPosition: .trailing) {
    // Action
}
```

##### Full Width & Disabled States

```swift
// Full width button
SButton("Submit", fullWidth: true) {
    // Action
}

// Disabled button
SButton("Not Available", isEnabled: false) {
    // This action won't trigger
}
```
</details>

---

### SAccordion
A vertically stacked set of interactive headings that each reveal a section of content.

<details>
<summary>More about SAccordion</summary>

#### Usage

```swift
import SwiftUI
import SwiftCN

struct AccordionExample: View {
    var body: some View {
        SAccordion(type: .single, defaultOpenItems: ["item-1"]) {
            SAccordionItem(id: "item-1", title: "Is it accessible?") {
                Text("Yes. It adheres to the WAI-ARIA design pattern.")
                    .padding() // Add padding to content
            }
            SAccordionItem(id: "item-2", title: "Is it styled?") {
                Text("Yes. It comes with default styles that matches the other components' aesthetic.")
                    .padding()
            }
            SAccordionItem(id: "item-3", title: "Is it animated?") {
                Text("Yes. It's animated by default, but you can disable it if you prefer.")
                    .padding()
            }
        }
        .padding() // Add padding around the accordion
    }
}
```

#### Types
- `.single`: Allows only one item to be open at a time.
- `.multiple`: Allows multiple items to be open simultaneously (default).

#### Customization
- `defaultOpenItems`: An array of item IDs that should be open by default.
- `SAccordionItem`:
    - `id`: A unique string identifier for the item.
    - `title`: The text displayed in the item's header.
    - `icon`: An optional `Image` to display next to the title (not implemented in the current version shown).
    - `content`: The view to display when the item is open.
</details>

---
    
### SAlert
The `SAlert` component displays important messages in different styles.

<details>
<summary>More about the SAlert</summary>

#### Basic Usage

```swift
// Default alert with title and description
SAlert(
    title: "Heads up!",
    description: "This is an important message."
)

// Destructive alert
SAlert(
    title: "Warning",
    description: "This action cannot be undone.",
    variant: .destructive
)

// Success alert
SAlert(
    title: "Success",
    description: "Your changes have been saved.",
    variant: .success
)
```

#### Alert Variants

```swift
// Default variant
SAlert(title: "Default", description: "Message...", variant: .default_)

// Destructive variant
SAlert(title: "Destructive", description: "Message...", variant: .destructive)

// Success variant
SAlert(title: "Success", description: "Message...", variant: .success)

// Warning variant
SAlert(title: "Warning", description: "Message...", variant: .warning)
```

#### Custom Content
```swift
SAlert(title: "Custom Content") {
    VStack(alignment: .leading, spacing: 8) {
        Text("You can add any custom content here.")
        SButton("Take Action", size: .sm) {
            // Handle action
        }
    }
}
```

#### Custom Icon
```swift
SAlert(
    title: "Custom Icon",
    description: "This alert uses a custom icon.",
    icon: Image(systemName: "star.fill")
)

```
</details>

---

### SAlertDialog
The `SAlertDialog` component is a modal dialog that appears on top of the entire application.

<details>
<summary>More about the SAlertDialog</summary>

#### Setup

First, add the `withAlertDialogs()` modifier to your root view:

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .withAlertDialogs()
        }
    }
}
```

#### Basic Usage
```swift
SAlertDialog { openAction in
    SButton("Open Dialog") {
        openAction()
    }
} content: {
    VStack(alignment: .leading, spacing: 0) {
        SAlertDialogParts.Title("Are you sure?")
        SAlertDialogParts.Description("This action cannot be undone.")
        
        SAlertDialogParts.Footer {
            SButton("Cancel", variant: .outline) {
                AlertDialogController.shared.dismiss()
            }
            
            SButton("Continue") {
                // Perform action
                AlertDialogController.shared.dismiss()
            }
        }
    }
}
``` 
</details>

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

## 🗺️ Roadmap
SwiftCN is just getting started! Here's what's coming:
- [x] Accordion
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
