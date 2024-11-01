// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MunkiFacts",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(name: "munkifacts", targets: ["MunkiFacts"]),
        .library(name: "FactPlugin", targets: ["FactPlugin"])
    ],
    targets: [
        .executableTarget(
            name: "MunkiFacts",
            dependencies: ["FactPlugin"]),
        .target(
            name: "FactPlugin",
            dependencies: []),
    ]
)