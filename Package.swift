// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RKBreadCrumb",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "RKBreadCrumb",
            targets: ["RKBreadCrumb"]),
    ],
    targets: [
        .target(
            name: "RKBreadCrumb",
            dependencies: []),
        .testTarget(
            name: "RKBreadCrumbTests",
            dependencies: ["RKBreadCrumb"]),
    ]
)
