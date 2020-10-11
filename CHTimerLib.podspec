Pod::Spec.new do |spec|
  spec.name         = "CHTimerLib"
  spec.version      = "1.0.0"
  spec.summary      = "iOS常用的三种定时器"
  spec.description  = <<-DESC
  为iOS中三种常用的定时器NSTimer、CADisplayLink、GCD，添加快捷创建的方法。
                   DESC
  spec.homepage     = "https://chocklee.github.io"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "ChanghaoLi" => "chocklee@yeah.net" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/chocklee/CHTimerLib.git", :tag => "#{spec.version}" }
  spec.source_files = "Classes", "Classes/**/*.{h,m}"
  spec.frameworks   = 'Foundation'
  spec.requires_arc = true

end
