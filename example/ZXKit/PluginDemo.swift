//
//  PluginDemo.swift
//  ZXKit
//
//  Created by Damon on 2021/4/23.
//

import UIKit

class PluginDemo: NSObject {

}

extension PluginDemo: ZXKitPluginProtocol {
    var pluginIcon: UIImage? {
        return UIImage(named: "zxkit")
    }

    var pluginTitle: String {
        return "插件测试"
    }

    var pluginType: ZXKitPluginType {
        return .ui
    }

    func start() {
        print("点击开始使用该插件")
    }
}
