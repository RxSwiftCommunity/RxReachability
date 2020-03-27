// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "RxReachability",
    products: [
        .library(name: "RxReachability", targets: ["RxReachability"])
    ],
    dependencies:[
        .package(url:"https://github.com/ashleymills/Reachability.swift", from: "5.0.0"),
        .package(url:"https://github.com/ReactiveX/RxSwift", from: "5.0.0")
    ],
    targets: [
        .target(name: "RxReachability",
                dependencies:["Reachability","RxSwift","RxCocoa"],
                path:"RxReachability",
                sources:["Sources"])
    ]
)