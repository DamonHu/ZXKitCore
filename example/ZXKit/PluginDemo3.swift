//
//  PluginDemo3.swift
//  ZXKit
//
//  Created by Damon on 2021/4/23.
//

import UIKit

class PluginDemo3: NSObject {

}

extension PluginDemo3: ZXKitPluginProtocol {
    var pluginIdentifier: String {
        return "com.zxkit.pluginDemo3"
    }
    
    var pluginIcon: UIImage? {
        return UIImage(named: "test2")
    }

    var pluginTitle: String {
        return "其他"
    }

    var pluginType: ZXKitPluginType {
        return .other
    }

    func start() {
        print("点击开始使用该插件")
    }

    var isRunning: Bool {
        return false
    }

    func stop() {

    }
}
