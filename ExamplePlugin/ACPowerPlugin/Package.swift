// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "ACPowerPlugin",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        .package(url: "https://github.com/joncrain/MunkiFacts-Swift", from: "0.0.1")
    ],
    targets: [
        .executableTarget(
            name: "ACPowerPlugin",
            dependencies: [.product(name: "FactPlugin", package: "MunkiFacts-Swift")]
        )
    ]
)