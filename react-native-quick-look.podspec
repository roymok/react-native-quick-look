require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = package['author']
  s.homepage     = package['homepage']
  s.platforms    = { :ios => "9.0", :osx => "10.14" }

  s.source       = { :git => "https://github.com/roymok/react-native-quick-look.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/ReactNativeQuickLook/**/*.{h,m}"

  s.dependency 'React'
end