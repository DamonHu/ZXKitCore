//
//  ViewController.swift
//  ZXKit
//
//  Created by Damon on 2021/4/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ZXKit.show()
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        //第二种
        ZXKit.regist(plugin: PluginDemo2())
        ZXKit.regist(plugin: PluginDemo2())
        ZXKit.regist(plugin: PluginDemo2())
        ZXKit.regist(plugin: PluginDemo2())
        ZXKit.regist(plugin: PluginDemo2())
        ZXKit.regist(plugin: PluginDemo2())

        ZXKit.regist(plugin: PluginDemo3())
    }

}

