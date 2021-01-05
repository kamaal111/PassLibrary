Pod::Spec.new do |spec|

  spec.name         = "PassLibrary"
  spec.version      = "3.0.0"
  spec.summary      = "Swift package to open PKPasses in your iOS app"

  spec.description  = <<-DESC
Swift package to open PKPasses in your iOS app.
                   DESC

  spec.homepage     = "https://github.com/kamaal111/PassLibrary"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "kamaal111" => "kamaal.f1@gmail.com" }

  spec.ios.deployment_target = "9"
  spec.swift_version = "5.2"

  spec.source        = { :git => "https://github.com/kamaal111/PassLibrary.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/PassLibrary/**/*.{h,m,swift}"

end