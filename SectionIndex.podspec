Pod::Spec.new do |s|
  s.name             = 'SectionIndex'
  s.version          = '0.3.0'
  s.summary          = 'A section index in SwiftUI that easily bridges to UIKit'

  s.description      = 'This library adds a UITableView-like section index that ' \
                       'is easily added to a SwiftUI interface or even as a '     \
                       'standalone SwiftUI element within an AppKit or UIKit app.'

  s.homepage         = 'https://github.com/amonshiz/SectionIndex'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew Monshizadeh' => 'amonshiz@gmail.com' }
  s.source           = { :git => 'https://github.com/amonshiz/SectionIndex.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/amonshiz'

  s.ios.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  s.osx.deployment_target = '10.15'
  s.swift_versions = ['5.0']

  s.source_files = 'Sources/**/*'
  
  s.frameworks = 'SwiftUI'
end
