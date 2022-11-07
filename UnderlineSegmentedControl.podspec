
Pod::Spec.new do |spec|

  spec.name         = "UnderlineSegmentedControl"
  spec.version      = "1.0.1"
  spec.summary      = "A customizable underline segmented control"
  spec.description  = "The native UISegmentedControl is hard to customize any way we want. I created one by extending UIControl. It has an underline that moves alongside the scrollview that you can attach to it. The colors of the segment titles change interactively as well."
  spec.homepage     = "https://github.com/lussvontrier/UnderlineSegmentedControl"
  spec.license      = "MIT"
  spec.author             = { "Lusine" => "limonella.lm@gmail.com" }
  spec.social_media_url   = "https://www.instagram.com/lussvontrier/"
  spec.platform     = :ios, "15.5"
  spec.source       = { :git => "https://github.com/lussvontrier/UnderlineSegmentedControl.git", :tag => spec.version.to_s }
  spec.vendored_frameworks = "UnderlineSegmentedControl.xcframework"
  spec.source_files  = "UnderlineSegmentedControl/**/*.{swift}"
  spec.frameworks = "QuartzCore", "UIKit"
  spec.swift_versions = "5.0"

end
