Pod::Spec.new do |s|
  s.name         = "SiYuanKit"
  s.version      = "1.0.1"
  s.summary      = "SiYuanKit is a personal swift toolbox."

  s.description  = "SiYuanKit is a personal swift toolbox."

  s.homepage     = "https://github.com/jindulys/SiYuanKit"

  s.license      = "MIT"
  s.author       = { "yansong li" => "857367901@qq.com" }
  s.source       = { :git => "https://github.com/jindulys/SiYuanKit.git", :tag => s.version }

  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source_files = "Sources/**/*.*"
  s.requires_arc = true
end
