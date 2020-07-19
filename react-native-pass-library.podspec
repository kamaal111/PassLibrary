require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-pass-library"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-pass-library
                   DESC
  s.homepage     = "https://github.com/kamaal111/PassLibrary"
  s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Kamaal Farah" => "kamaal.f1@gmail.com" }
  s.platforms    = { :ios => "11.0" }
  s.source       = { :git => "https://github.com/kamaal111/PassLibrary.git", :tag => "#{s.version}" }

  s.source_files = "Sources/**/*, react-native-pass-library/PassLibraryBridge.m"
  s.requires_arc = true

  s.dependency "React"

end

