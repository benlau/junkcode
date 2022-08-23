Pod::Spec.new do |s|
    s.name = 'OpenCV'
    s.version = '4.5.5'
    s.summary = 'OpenCV (Computer Vision) for osx'
    s.homepage = 'http://github.com/benlau/junkcode'
  
    s.license = { type: 'Apache License, Version 2.0', file: 'LICENSE' }
    s.author = 'https://github.com/opencv/opencv/graphs/contributors'
  
    s.source = { http: "https://github.com/benlau/junkcode/releases/download/#{s.version}/opencv2.xcframework.zip" }

    s.platform = :osx
                        
    s.deployment_target = '10.12'
    s.preserve_paths = '*'
  
    s.libraries = 'c++'
    s.requires_arc = false
    s.frameworks = 'Accelerate', 'AVFoundation', 'CoreGraphics', 'CoreImage', 'CoreMedia', 'CoreVideo', 'Foundation', 'opencv2', 'QuartzCore'
end