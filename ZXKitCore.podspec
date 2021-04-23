Pod::Spec.new do |s|
s.name = 'ZXKitCore'
s.swift_version = '5.0'
s.version = '0.0.6'
s.license= { :type => "Apache-2.0 License", :file => "LICENSE" }
s.summary = 'ZXKit Core'
s.homepage = 'https://github.com/ZXKitCode/core'
s.authors = { 'ZXKitCode' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/ZXKitCode/core.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '10.0'
s.subspec 'Core' do |cs|
    cs.source_files = "pod/extend/*.swift","pod/*.swift"
end
s.subspec 'idfa' do |cs|
    cs.source_files = "pod/subspec/ZXKit+idfa.swift"
    cs.dependency 'ZXKitCore/Core'
end
s.default_subspecs = "Core"
s.documentation_url = 'http://blog.hudongdong.com/swift/1079.html'
end
