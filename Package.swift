// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreDB",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "CoreDB", targets: ["CoreDB"])
    ],
    dependencies: [
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa", from: "10.0.0"),
    ],
    targets: [
        .target(name: "CoreDB", dependencies: [.product(name: "RealmSwift", package: "Realm")]),
        .testTarget(name: "CoreDBTests", dependencies: ["CoreDB"])
    ]
)
