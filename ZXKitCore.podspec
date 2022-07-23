Pod::Spec.new do |s|
s.name = 'ZXKitCore'
s.swift_version = '5.0'
s.version = '0.1.6'
s.license= { :type => "Apache-2.0 License", :file => "LICENSE" }
s.summary = 'ZXKitCore is the supporting framework of ZXKitSwift, for ZXKitSwift plugin developers'
s.homepage = 'https://github.com/ZXKitCode/core'
s.authors = { 'ZXKitCode' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/ZXKitCode/core.git", :tag => s.version}
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
# s.subspec 'common' do |cs|
#     cs.dependency 'ZXKitCore/core'
#     cs.dependency 'ZXKitLogger/zxkit'
# end
s.default_subspec = "core"
s.documentation_url = 'http://blog.hudongdong.com/swift/1079.html'
end
