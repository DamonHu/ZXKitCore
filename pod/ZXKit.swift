//
//  ZXKit.swift
//  ZXKit
//
//  Created by Damon on 2021/4/23.
//

import UIKit
import ZXKitUtil
import ZXKitLogger

extension String{
    var ZXLocaleString: String {
        guard let bundlePath = Bundle(for: ZXKit.self).path(forResource: "ZXKitCore", ofType: "bundle") else { return NSLocalizedString(self, comment: "") }
        guard let bundle = Bundle(path: bundlePath) else { return NSLocalizedString(self, comment: "") }
        let msg = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        return msg
    }
}

func UIImageHDBoundle(named: String?) -> UIImage? {
    guard let name = named else { return nil }
    guard let bundlePath = Bundle(for: ZXKit.self).path(forResource: "ZXKitCore", ofType: "bundle") else { return UIImage(named: name) }
    guard let bundle = Bundle(path: bundlePath) else { return UIImage(named: name) }
    return UIImage(named: name, in: bundle, compatibleWith: nil)
}

public extension NSNotification.Name {
    static let ZXKitPluginRegist = NSNotification.Name("ZXKitPluginRegist")
    static let ZXKitShow = NSNotification.Name("ZXKitShow")
    static let ZXKitHide = NSNotification.Name("ZXKitHide")
    static let ZXKitClose = NSNotification.Name("ZXKitClose")
}

public class ZXKit: NSObject {
    public static var UIConfig = ZXKitUIConfig()
    public static let DebugFolderPath = ZXKitUtil.shared.createFileDirectory(in: .caches, directoryName: "zxkit")
    private static var hasConfig = false
    private static var window: ZXKitWindow?
    private static var floatWindow: ZXKitFloatWindow?
    private static var floatChangeTimer: Timer?     //悬浮按钮的修改
    private static var isFloatChange = false          //悬浮按钮是否在修改
    private static var changeQueue = [ZXKitButtonConfig]() //悬浮按钮修改的队列
    static var pluginList = [[ZXKitPluginProtocol](), [ZXKitPluginProtocol](), [ZXKitPluginProtocol]()]
}

public extension ZXKit {
    static func regist(plugin: ZXKitPluginProtocol) {
        if !hasConfig {
            self._initConfig()
        }
        var index = 0
        switch plugin.pluginType {
            case .ui:
                index = 0
            case .data:
                index = 1
            case .other:
                index = 2
        }
        if !self.pluginList[index].contains(where: { (tPlugin) -> Bool in
            return tPlugin.pluginIdentifier == plugin.pluginIdentifier
        }) {
            self.pluginList[index].append(plugin)
        }
        if let window = self.window, !window.isHidden {
            DispatchQueue.main.async {
                window.reloadData()
            }
        }
        NotificationCenter.default.post(name: .ZXKitPluginRegist, object: self.pluginList)
    }

    static func show() {
        if !hasConfig {
            self._initConfig()
        }
        NotificationCenter.default.post(name: .ZXKitShow, object: nil)
        DispatchQueue.main.async {
            self.floatWindow?.isHidden = true
            if let window = self.window {
                window.isHidden = false
            } else {
                if #available(iOS 13.0, *) {
                    for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                        if windowScene.activationState == .foregroundActive {
                            self.window = ZXKitWindow(windowScene: windowScene)
                            self.window?.frame = UIScreen.main.bounds
                        }
                    }
                }
                if self.window == nil {
                    self.window = ZXKitWindow(frame: UIScreen.main.bounds)
                }
                self.window?.isHidden = false
                self.window?.reloadData()
            }
        }
    }

    static func hide() {
        NotificationCenter.default.post(name: .ZXKitHide, object: nil)
        DispatchQueue.main.async {
            self.window?.isHidden = true
            //float window
            if let window = self.floatWindow {
                window.isHidden = false
            } else {
                if #available(iOS 13.0, *) {
                    for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                        if windowScene.activationState == .foregroundActive {
                            self.floatWindow = ZXKitFloatWindow(windowScene: windowScene)
                            self.floatWindow?.frame = CGRect(x: UIScreen.main.bounds.size.width - 80, y: 100, width: 60, height: 60)
                        }
                    }
                }
                if self.floatWindow == nil {
                    self.floatWindow = ZXKitFloatWindow(frame: CGRect(x: UIScreen.main.bounds.size.width - 80, y: 100, width: 60, height: 60))
                }
                self.floatWindow?.isHidden = false
            }
            self.floatWindow?.setBadge(value: "\(ZXKitLogger.getItemCount(type: .error))", index: 3)
        }
    }

    static func close() {
        NotificationCenter.default.post(name: .ZXKitClose, object: nil)
        DispatchQueue.main.async {
            self.window?.isHidden = true
            self.floatWindow?.isHidden = true
        }
    }
    
    static func updateFloatButton(config: ZXKitButtonConfig) {
        if let last = self.changeQueue.last, last == config {
            //如果和最后一次重复就不再添加
            return
        }
        self.changeQueue.append(config)
        if self.isFloatChange {
            return
        }
        if let floatWindow = self.floatWindow {
            self.floatChangeTimer?.invalidate()
            self.floatChangeTimer = Timer(timeInterval: 2, repeats: true, block: { _ in
                DispatchQueue.main.async {
                    if self.changeQueue.isEmpty {
                        //队列已循环完毕
                        floatWindow.menuStatus = .collapsed
                        self.isFloatChange = false
                        self.floatChangeTimer?.invalidate()
                        self.floatChangeTimer = nil
                    } else {
                        self.isFloatChange = true
                        floatWindow.menuStatus = .info(config: self.changeQueue.first!)
                        self.changeQueue.removeFirst()
                    }
                }
            })
            RunLoop.main.add(self.floatChangeTimer!, forMode: .common)
            self.floatChangeTimer?.fire()
        }
    }

    static func showInput(placeholder: String?, text: String?, complete: ((String)->Void)?) {
        ZXKit.show()
        self.window?.showInput(placeholder: placeholder, text: text, complete: complete)
    }
}

private extension ZXKit {
    static func _initConfig() {
        if hasConfig {
            return
        }
        self.hasConfig = true
        self.regist(plugin: ZXKitLogger.shared)
        NotificationCenter.default.addObserver(self, selector: #selector(_logUpdate(notification: )), name: .ZXKitLogDBUpdate, object: nil)
    }
    
    @objc static func _logUpdate(notification: Notification) {
        print(notification.object)
        if let object = notification.object as? [String: Any] {
            if let floatWindow = self.floatWindow {
                floatWindow.setBadge(value: "\(ZXKitLogger.getItemCount(type: .error))", index: 3)
            }
        }
    }
}
