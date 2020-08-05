// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SectionIndex",
  platforms: [.iOS(.v13), .watchOS(.v6), .macOS(.v10_15)],
  products: [
    .library(
        name: "SectionIndex",
        targets: ["SectionIndex"]),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
        name: "SectionIndex",
        dependencies: []),
    .testTarget(
        name: "SectionIndexTests",
        dependencies: ["SectionIndex"]),
  ]
)
