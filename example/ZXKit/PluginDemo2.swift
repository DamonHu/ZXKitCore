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
    var pluginIcon: UIImage? {
        return UIImage(named: "zxkit2")
    }

    var pluginTitle: String {
        return "插件测试2"
    }

    var pluginType: ZXKitPluginType {
        return .data
    }

    func start() {
        print("点击开始使用该插件2222222")
    }


}
