// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PassLibrary",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "PassLibrary",
            targets: ["PassLibrary"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PassLibrary",
            dependencies: [])
        .testTarget(
            name: "PassLibraryTests",
            dependencies: ["PassLibrary"])
    ]
)
