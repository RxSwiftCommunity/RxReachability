// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxReachability",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v8),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "RxReachability",
            targets: ["RxReachability"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/ashleymills/Reachability.swift.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "RxReachability",
            dependencies: [
                "RxSwift", "ReachabilitySwift",
                .product(name: "RxCocoa", package: "RxSwift")
        ]),
        .testTarget(
            name: "RxReachabilityTests",
            dependencies: ["RxReachability"]),
    ]
)
