

Pod::Spec.new do |s|

  s.name         = "OXCMantle"
  s.version      = "1.0.0"
  s.summary      = "在Mantle的基础上夹生了类型验证"
  s.description  = <<-DESC
                   A longer description of OXCen in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/hytzxd/OXCMantle"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "张旭东" => "xudongzhang999@163.com" }
  s.platform     = :ios ,"7.0"
 
  s.source       = { :git => "https://github.com/hytzxd/OXCMantle.git", :branch => "master", :tag => '1.0.0' }
  s.requires_arc = true
  s.source_files  =  'OXCMantle/Classes/**/*.{h,m}'
  s.dependency 'Mantle', '~> 2.0'
 

  

end
