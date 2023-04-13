//
//  ViewController.swift
//  ZXKit
//
//  Created by Damon on 2021/4/23.
//

import UIKit
import ZXKitLogger

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
        
        printError("error")
        printError("error")
        printError("error")
    }

    func createUI() {
        self.view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.setTitle("open debug tool", for: .normal)
        button.backgroundColor = UIColor.red
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(_click), for: .touchUpInside)


        let button2 = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        button2.setTitle("show input window", for: .normal)
        button2.backgroundColor = UIColor.red
        self.view.addSubview(button2)
        button2.addTarget(self, action: #selector(_showInput), for: .touchUpInside)

        let button3 = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 50))
        button3.setTitle("change float button", for: .normal)
        button3.backgroundColor = UIColor.red
        self.view.addSubview(button3)
        button3.addTarget(self, action: #selector(_updateFloatButton), for: .touchUpInside)

    }

    @objc func _click() {
        ZXKit.show()
    }

    @objc func _showInput() {
        ZXKit.show(.input(placeholder: "placeholder", text: nil, endEdit: { text in
            print(text)
        }))
    }

    @objc func _updateFloatButton() {
        for i in 0..<10 {
            let config = ZXKitButtonConfig(title: "test\(i)", titleColor: UIColor.white, titleFont: .systemFont(ofSize: 17), backgroundColor: nil)
            ZXKit.updateFloatButton(config: config, plugin: PluginDemo())
        }
    }
}

