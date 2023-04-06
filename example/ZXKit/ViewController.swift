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
        //regist
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        ZXKit.regist(plugin: PluginDemo())
        //第二种
        ZXKit.regist(plugin: PluginDemo2())
        //other
        ZXKit.regist(plugin: PluginDemo3())

        self.createUI()
    }

    func createUI() {
        self.view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = UIColor.red
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(_click), for: .touchUpInside)
    }

    @objc func _click() {
        ZXKit.show()
        
        ZXKit.showInput(placeholder: "输入文字", text: nil) { text in
            print(text)
        }
    }

}

