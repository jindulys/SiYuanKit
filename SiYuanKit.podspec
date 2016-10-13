Pod::Spec.new do |s|
  s.name         = "SiYuanKit"
  s.version      = "1.2.5"
  s.summary      = "SiYuanKit is a personal swift toolbox."

  s.description  = "SiYuanKit is a personal swift toolbox. Treasures."

  s.homepage     = "https://github.com/jindulys/SiYuanKit"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "yansong li" => "857367901@qq.com" }
  s.source       = { :git => "https://github.com/jindulys/SiYuanKit.git", :tag => s.version }

  s.platform     = :ios, "10.0"
  s.ios.deployment_target = "10.0"
  s.requires_arc = true

  ### Subspecs

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

  s.subspec 'Extension' do |es|
    es.source_files = "Sources/UI/Extension/*.*"
  end  

  s.subspec 'StaticTableView' do |ts|
    ts.dependency 'SiYuanKit/Extension'
    ts.source_files = "Sources/UI/StaticTableView/**/*.*"
  end
end
