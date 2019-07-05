Pod::Spec.new do |s|
  s.name = "QLCommonUtils"
  s.version = "0.1.2"
  s.summary = "a common utils for ios project"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Paramita"=>"baqkoo007@aliyun.com"}
  s.homepage = "https://github.com/burtworld/QLCommonUtils"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/QLCommonUtils.embeddedframework/QLCommonUtils.framework'
end
