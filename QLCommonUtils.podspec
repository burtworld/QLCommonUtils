#
# Be sure to run `pod lib lint QLCommonUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QLCommonUtils'
  s.version          = '0.1.3'
  s.summary          = 'a common utils for ios project'

  s.homepage         = 'https://github.com/burtworld/QLCommonUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paramita' => 'baqkoo007@aliyun.com' }
  s.source           = { :git => 'https://github.com/burtworld/QLCommonUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'QLCommonUtils/Classes/**/*'
  
  # s.resource_bundles = {
  #   'QLCommonUtils' => ['QLCommonUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Base64'
#  s.dependency 'FMDB/SQLCipher'
  s.dependency 'RTRootNavigationController', '~> 0.7.0'
#  s.dependency 'SDWebImage'
  s.dependency 'SVProgressHUD', '~> 2.2.5'
  s.dependency 'MBProgressHUD'
  s.dependency 'Masonry'
end
