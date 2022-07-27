# ZXKitCore

![](https://img.shields.io/badge/CocoaPods-supported-brightgreen) ![](https://img.shields.io/badge/Swift-5.0-brightgreen) ![](https://img.shields.io/badge/License-MIT-brightgreen) ![](https://img.shields.io/badge/version-iOS11.0-brightgreen)

[中文文档](./README.md)

`ZXKitCore` is the supporting framework of zxkit plug-ins. It provides plug-in display, management and other functions. You can quickly develop and display zxkit plug-ins by implementing the `ZXKitPluginProtocol`. This document provides plug-in development tutorials and use tutorials, which developers can view as needed.

> 天地不仁，以万物为刍狗
> 
> The world is not benevolent, and everything is a dog

## Develop a ZXKit plugin

## 1. Import the core file

Project import `ZXKitCore`, you can use cocoapods to quickly import core files

```
pod 'ZXKitCore/core'
```

## 2. Implement the protocol

Declare an object and follow the `ZXKitPluginProtocol` protocol.

```
class PluginDemo: NSObject {
    var isPluginRunning = true
}

extension PluginDemo: ZXKitPluginProtocol {
	 //Unique identification
    var pluginIdentifier: String {
        return "com.zxkit.pluginDemo"
    }
    
    var pluginIcon: UIImage? {
        return UIImage(named: "zxkit")
    }

    var pluginTitle: String {
        return "title"
    }

    var pluginType: ZXKitPluginType {
        return .ui
    }

    func start() {
        print("start plugin")
        isPluginRunning = true
    }
    
    var isRunning: Bool {
        return isPluginRunning
    }

    func stop() {
        print("plugin stop running")
        isPluginRunning = false
    }
}
```

### 3. Register the plug-in

After that, you can register the plug-in, you only need to register once globally


```
ZXKit.regist(plugin: PluginDemo())
```

### 4. Done

After cocoapods is released and online, when the user opens `ZXKit`, your plug-in will appear on the debug collection page

### 5. More configurations

#### 5.1、get floate button

```
ZXKit.floatButton
```

#### 5.2、reset Float Button

```
ZXKit.resetFloatButton()
```

#### 5.3、Display textField

```
ZXKit.showInput { (text) in
	print(text)
}
```

#### 5.4、get textField

```
ZXKit.textField
```

### NSNotification

`ZXKitCore` provides the following message notifications, you can get the frame display, hide, close, and register new plug-in timing by binding the following notifications

```
//new plug-in regist
NSNotification.Name.ZXKitPluginRegist
//show
NSNotification.Name.ZXKitShow
//hide
NSNotification.Name.ZXKitHide
//close
NSNotification.Name.ZXKitClose
```

## Install and use a zxkit plugin

The zxkit plug-in is easy to use. For example, install the log plugin `ZXKitLogger`.

### install it

```
pod 'ZXKitLogger/zxkit'
```
### regist it

```
ZXKit.regist(plugin: ZXKitLogger.shared)
```

### open the plugin list

```
ZXKit.show()
```

### hide the plugin list

```
ZXKit.hide()
```

### close the plugin list

```
ZXKit.close()
```

## ZXKitSwift

We have released a cocoaPods library named [ZXKitSwift](https://github.com/ZXKitCode/ZXKitSwift), which is a tool library that integrates multiple ZXKit-plugins。It can help you quickly use multiple debugging functions

## License

ZXKitCore is released under the MIT license. 
