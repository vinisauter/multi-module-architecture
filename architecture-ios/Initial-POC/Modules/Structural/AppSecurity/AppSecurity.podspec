Pod::Spec.new do |s|
    s.name             = 'AppSecurity'
    s.version          = '1.0.1'
    s.summary          = 'AppSecurity base library'
    s.description      = 'Library with AppSecurity classes'
  
    s.homepage         = 'https://github.com/FelippeMatos/multi-structural-module'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'giovane_barreira@hotmail.com' => 'giovane.barreira@avanade.com' }
    s.source           = { :git => 'https://github.com/FelippeMatos/multi-structural-module.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '11.0'
    s.exclude_files = 'AppSecurity/Config/*.{plist}'
  
    s.source_files = 'AppSecurity', 'AppSecurity/**/*'
    s.dependency 'AppSecurityInterfaces', '1.0.1'

  end