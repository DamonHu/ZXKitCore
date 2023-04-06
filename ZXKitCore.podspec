Pod::Spec.new do |s|
s.name = 'ZXKitCore'
s.swift_version = '5.0'
s.version = '1.0.0'
s.license= { :type => "MIT", :file => "LICENSE" }
s.summary = 'ZXKitCore is the supporting framework of ZXKitSwift, for ZXKitSwift plugin developers'
s.homepage = 'https://github.com/DamonHu/ZXKitCore'
s.authors = { 'ZXKitCode' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/DamonHu/ZXKitCore.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '11.0'
s.subspec 'core' do |cs|
    cs.resource_bundles = {
        'ZXKitCore' => ['pod/localizable/**/*']
    }
    cs.source_files = "pod/*.swift", "pod/localizable/**/*"
    cs.dependency 'SnapKit'
    cs.dependency 'ZXKitUtil'
end
s.default_subspec = "core"
s.documentation_url = 'https://blog.hudongdong.com/ios/1164.html'
end
