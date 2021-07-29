// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LinkPlay",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "LinkPlay", targets: ["LinkPlay"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "LinkPlay", dependencies: [], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
