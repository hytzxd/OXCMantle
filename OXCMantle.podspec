

Pod::Spec.new do |s|

  s.name         = "OXCMantle"
  s.version      = "1.0.1"
  s.summary      = "在Mantle的基础上夹生了类型验证，修复了一些bug"
  s.description  = <<-DESC
                   在Mantle的基础上夹生了类型验证，修复了一些bug
                   修复了64位NSInteger不能正常转换的问题
                   DESC

  s.homepage     = "https://github.com/hytzxd/OXCMantle"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "张旭东" => "xudongzhang999@163.com" }
  s.platform     = :ios ,"7.0"
 
  s.source       = { :git => "https://github.com/hytzxd/OXCMantle.git", :branch => "master", :tag => '1.0.1' }
  s.requires_arc = true
  s.source_files  =  'OXCMantle/Classes/**/*.{h,m}'
  s.dependency 'Mantle', '<=2.0.6'
 

  

end
