// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmartbookCore",
    products: [
        .library(
            name: "SmartbookCore",
            targets: ["SmartbookCore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git", exact: Version("6.1.0")),
        .package(url: "https://github.com/mac-cain13/R.swift.git", from: Version("7.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SmartbookCore",
            dependencies: [
                .product(name: "RxAlamofire", package: "RxAlamofire"),
                .product(name: "RswiftLibrary", package: "R.swift"),
            ],
            path: "Sources",
            plugins: [.plugin(name: "RswiftGenerateInternalResources", package: "R.swift")]
        ),
        .testTarget(
            name: "SmartbookCoreTests",
            dependencies: ["SmartbookCore"]
        ),
    ]
)
