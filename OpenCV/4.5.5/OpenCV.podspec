Pod::Spec.new do |s|
    s.name         = "OpenCV"
    s.version      = "4.5.5"
    s.summary      = "OpenCV (Computer Vision) for iOS."
    s.homepage      = "https://opencv.org/."
  
    s.license      = 'BSD'
    s.author       = 'https://github.com/opencv/opencv/graphs/contributors'
  
    s.source       = { :http => "https://github.com/oursky/opencv/releases/download/4.5.5/opencv2.xcframework.zip" }

    s.module_name = "OpenCV"
  
    s.ios.deployment_target = "11.0"
    s.ios.frameworks = [
      "Accelerate"
    ]

    s.osx.deployment_target = "10.15"
    s.osx.frameworks = [
      'AssetsLibrary', 'AVFoundation', 'CoreGraphics', 'CoreMedia', 'CoreVideo', 'Foundation', 'QuartzCore'
    ]

    s.vendored_frameworks = 'ios-arm64/opencv2.xcframework'
    s.ios.vendored_frameworks = 'ios-arm64/opencv2.xcframework'
    
    s.libraries = 'c++'
    s.requires_arc = false
  end