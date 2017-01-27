import PackageDescription

let package = Package(
    name: "ProrsumSample",
    dependencies: [
        .Package(url: "https://github.com/noppoMan/Prorsum.git", majorVersion: 0, minor: 1),
    ]
)
