// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Profile",
    platforms:[
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Profile",
            targets: ["Profile"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name:"Networking",path:"../../Structural/Networking"),
        .package(name:"Analytics",path:"../../Structural/Analytics"),
        .package(name:"Core",path:"../../Structural/Core"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Profile",
            dependencies: ["Networking","Analytics","Core"],
            exclude:["Info.plist"]),
        .testTarget(
            name: "ProfileTests",
            dependencies: ["Profile"]),
    ]
)
