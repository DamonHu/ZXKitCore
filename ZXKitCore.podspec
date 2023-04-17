Pod::Spec.new do |s|
s.name = 'ZXKitCore'
s.swift_version = '5.0'
s.version = '2.0.3'
s.license= { :type => "MIT", :file => "LICENSE" }
s.summary = 'ZXKitCore is the supporting framework of ZXKitSwift, for ZXKitSwift plugin developers'
s.homepage = 'https://github.com/DamonHu/ZXKitCore'
s.authors = { 'ZXKitCode' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/DamonHu/ZXKitCore.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '11.0'
s.subspec 'core' do |cs|
    cs.resource_bundles = {
        'ZXKitCore' => ['pod/assets/**/*']
    }
    cs.source_files = "pod/*.swift", "pod/**/*.swift"
    cs.dependency 'ZXKitUtil', '~> 4.0'
    cs.dependency 'SSZipArchive'
    cs.dependency 'ZXKitLogger', '~> 4.0'
end
s.default_subspec = "core"
s.documentation_url = 'https://blog.hudongdong.com/ios/1164.html'
end
