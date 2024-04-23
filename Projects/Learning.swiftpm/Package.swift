// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Learning",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Learning",
            targets: ["AppModule"],
            bundleIdentifier: "com.vijaythakur.Learning",
            teamIdentifier: "9AS7TGQLM2",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .cloud),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)
