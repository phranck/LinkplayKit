// swift-tools-version:5.5
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
    dependencies: [
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "1.9.0")),
    ],
    targets: [
        .target(name: "LinkPlay", dependencies: ["SwiftyBeaver"], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
