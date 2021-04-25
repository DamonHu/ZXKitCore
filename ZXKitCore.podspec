Pod::Spec.new do |s|
s.name = 'ZXKitCore'
s.swift_version = '5.0'
s.version = '0.0.8'
s.license= { :type => "Apache-2.0 License", :file => "LICENSE" }
s.summary = 'ZXKit Core'
s.homepage = 'https://github.com/ZXKitCode/ZXKit'
s.authors = { 'ZXKitCode' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/ZXKitCode/ZXKit.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '11.0'
s.subspec 'core' do |cs|
    cs.source_files = "pod/*.swift", "pod/localizable/**/*"
    cs.dependency 'SnapKit'
    cs.dependency 'ZXKitUtil'
end
s.default_subspecs = "core"
s.documentation_url = 'http://blog.hudongdong.com/swift/1079.html'
end
