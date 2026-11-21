// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "ReadersTests",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "t_readers", targets: ["ReadersTests"]),
    ],
    dependencies: [
        .package(url: "https://github.com/leviouwendijk/Position.git", branch: "master"),
        .package(path: ".."),
        .package(url: "https://github.com/leviouwendijk/Errors.git", branch: "master"),
        .package(url: "https://github.com/leviouwendijk/IO.git", branch: "master"),
    ],
    targets: [
        .executableTarget(
            name: "ReadersTests",
            dependencies: [
                .product(name: "Readers", package: "Readers"),
                .product(name: "Position", package: "Position"),
                .product(name: "Errors", package: "Errors"),
                .product(name: "IO", package: "IO"),
            ]
        ),
    ]
)
