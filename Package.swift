// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "UnderlineSegmentedControl",
    platforms: [
	.iOS(.v15),
    ], 
    products: [
        .library(
            name: "UnderlineSegmentedControl",
            targets: ["UnderlineSegmentedControl"]),
    ],
    targets: [
        .target(
            name: "UnderlineSegmentedControl",
            path: "UnderlineSegmentedControl/UnderlineSegmentedControl")
    ], 
    swiftLanguageVersions: [.v5]
)
