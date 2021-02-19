#
# Be sure to run `pod lib lint BOCeClassifySelect.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BOCeClassifySelect'
  s.version          = '0.0.1'
  s.summary          = 'zhangwenxue'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'BOCeClassifySelect of BOCE'

  s.homepage         = 'https://github.com/guang1472006/BOCeClassifySelect'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '734781246@qq.com' => '734781246@qq.com' }
  s.source           = { :git => 'https://github.com/guang1472006/BOCeClassifySelect.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'BOCeClassifySelect/Classes/*'
  
  # s.resource_bundles = {
  #   'BOCeClassifySelect' => ['BOCeClassifySelect/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'Masonry', '~> 1.1.0'
  
end
