// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PassLibrary",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "PassLibrary",
            targets: ["PassLibrary"])
    ],
    dependencies: [
        .package(url: "https://github.com/kamaal111/XiphiasNet", from: "3.0.3")
    ],
    targets: [
        .target(
            name: "PassLibrary",
            dependencies: ["XiphiasNet"]),
        .testTarget(
            name: "PassLibraryTests",
            dependencies: ["PassLibrary"]),
    ]
)
