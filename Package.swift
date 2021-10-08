// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LinkplayKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "LinkplayKit", targets: ["LinkplayKit"]),
    ],
    dependencies: [
        .package(name: "SwiftyBeaver", url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.9.0"),
    ],
    targets: [
        .target(
            name: "LinkplayKit",
            dependencies: ["SwiftyBeaver"],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
