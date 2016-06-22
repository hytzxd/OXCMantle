

Pod::Spec.new do |s|

  s.name         = "OXCMantle"
  s.version      = "1.1.0"
  s.summary      = "在Mantle的基础上夹生了类型验证，修复了一些bug"
  s.description  = <<-DESC
                   在Mantle的基础上夹生了类型验证，修复了一些bug
                   修复了64位NSInteger不能正常转换的问题
                   DESC

  s.homepage     = "https://github.com/hytzxd/OXCMantle"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "张旭东" => "308325102@qq.com" }
  s.platform     = :ios ,"7.0"
  s.source       = { :git => "https://github.com/hytzxd/OXCMantle.git", :branch => "master", :tag => '1.1.0' }
  s.requires_arc = true
  s.source_files  =  'OXCMantle/Classes/*.{h}'
  s.dependency 'Mantle', '~> 2.0.7'
  s.frameworks = 'Foundation'
   s.subspec 'OXCValidation' do |OXCValidation|
      OXCValidation.source_files = 'OXCMantle/Classes/OXCValidation/**/*.{h,m}'
      OXCValidation.public_header_files = 'OXCMantle/Classes/OXCValidation/**/*h'
  end
  s.subspec 'OXCModel' do |OXCModel|
      OXCModel.source_files = 'OXCMantle/Classes/OXCModel/*.{h,m}'
      OXCModel.public_header_files = 'OXCMantle/Classes/OXCModel/*.h,'
      OXCModel.dependency 'Mantle', '~> 2.0.7' 
      OXCModel.dependency 'OXCMantle/OXCValidation'
  end
   
end
