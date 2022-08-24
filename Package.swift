// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "opencv2",
  platforms: [
        .macOS(.v10_12)
  ],
  products: [
      .library(
          name: "opencv2",
          targets: ["opencv2"]),
  ],
  targets: [
      .binaryTarget(name: "opencv2", 
        url: "https://github.com/benlau/junkcode/releases/download/4.5.5/opencv2.xcframework.zip", 
        checksum: "2594b3b2351a7d0368b6943292623303f41fc1151d8f496083e966757d117d99"
    )
  ]
)