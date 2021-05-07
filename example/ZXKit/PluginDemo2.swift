//
//  PluginDemo2.swift
//  ZXKit
//
//  Created by Damon on 2021/4/23.
//

import UIKit

class PluginDemo2: NSObject {

}

extension PluginDemo2: ZXKitPluginProtocol {
    var pluginIdentifier: String {
        return "com.zxkit.pluginDemo2"
    }
    
    var pluginIcon: UIImage? {
        return UIImage(named: "zxkit2")
    }

    var pluginTitle: String {
        return "插件"
    }

    var pluginType: ZXKitPluginType {
        return .data
    }

    func start() {
        print("点击开始使用该插件2222222")
    }

    var isRunning: Bool {
        return true
    }

    func stop() {
        print("该插件为系统插件，不能停止运行")
    }
}
