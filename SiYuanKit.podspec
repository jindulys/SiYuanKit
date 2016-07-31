Pod::Spec.new do |s|
  s.name         = "SiYuanKit"
  s.version      = "1.0.9"
  s.summary      = "SiYuanKit is a personal swift toolbox."

  s.description  = "SiYuanKit is a personal swift toolbox. Treasures."

  s.homepage     = "https://github.com/jindulys/SiYuanKit"

  s.license      = "MIT Copyright (c) 2016 YANSONG LI. All rights reserved."
  s.author       = { "yansong li" => "857367901@qq.com" }
  s.source       = { :git => "https://github.com/jindulys/SiYuanKit.git", :tag => s.version }

  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.requires_arc = true
  s.default_subspec = 'Core'

  ### Subspecs

  s.subspec 'Core' do |cs|
    cs.dependency 'SiYuanKit/YSOperations'
    cs.dependency 'SiYuanKit/Then'
    cs.dependency 'SiYuanKit/Utilities'
  end

  s.subspec 'DispatchQueue' do |ds|
    ds.source_files = "Sources/DispatchQueue/*.*"
  end

  s.subspec 'Then' do |ts|
    ts.source_files = "Sources/Then/*.*"
  end

  s.subspec 'YSOperations' do |ys|
    ys.dependency 'SiYuanKit/DispatchQueue'
    ys.source_files = "Sources/YSOperations/**/*.*"
  end

  s.subspec 'Utilities' do |us|
    us.dependency 'SiYuanKit/DispatchQueue'
    us.source_files = "Sources/Utilities/*.*"
  end

end
