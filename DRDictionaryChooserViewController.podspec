#
# Be sure to run `pod lib lint DRDictionaryChooserViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DRDictionaryChooserViewController"
  s.version          = "0.1.0"
  s.summary          = "A class for letting the user choose from a list"

  s.description      = "This class presents a view controller, letting the user choose from a list."


  s.homepage         = "https://github.com/dorada/DRDictionaryChooserViewController"
  s.screenshots     = "https://github.com/dorada/DRDictionaryChooserViewController/tree/master/Example/screenshot.jpg"
  s.license          = 'MIT'
  s.author           = { "Daniel Broad" => "daniel@dorada.org" }
  s.source           = { :git => "https://github.com/dorada/DRDictionaryChooserViewController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DRDictionaryChooserViewController' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
