// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Readers",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Readers",
            targets: ["Readers"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-lco/IO.git", branch: "master"),
        .package(url: "https://github.com/swift-lco/Errors.git", branch: "master"),
        .package(url: "https://github.com/swift-lco/Position.git", branch: "master"),
        .package(url: "https://github.com/swift-lco/FileTypes.git", branch: "master"),
    ],
    targets: [
        .target(
            name: "Readers",
            dependencies: [
                .product(name: "IO", package: "IO"),
                .product(name: "Errors", package: "Errors"),
                .product(name: "Position", package: "Position"),
                .product(name: "FileTypes", package: "FileTypes"),
            ],
        ),
    ]
)
