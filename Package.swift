// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SwiftShadUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "SwiftShadUI",
            targets: ["SwiftShadUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftShadUI",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftShadUITests",
            dependencies: ["SwiftShadUI"]),
    ]
)
