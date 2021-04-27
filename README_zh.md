# ZXKitCore

`ZXKitSwift`是一个iOS平台整合的开发调试工具，名字取自我很喜欢的一本小说《诛仙》。`ZXKitCore`是`ZXKitSwift`的支撑框架，主要针对`ZXKitSwift`拓展开发者使用。

> 天地不仁，以万物为刍狗


## 一、为ZXKit增加plugin

如果需要开发自定义插件，只需要实现`ZXKitPluginProtocol`即可。实现的方式很简单。

## 1、导入核心文件

项目导入`ZXKitCore`，可使用cocoapods快速导入核心文件

```
pod 'ZXKitCore/core'
```

## 2、实现协议

声明一个对象，遵守`ZXKitPluginProtocol`协议即可。分别返回对应的icon、插件名字、插件类型分组、启动函数

```
extension PluginDemo: ZXKitPluginProtocol {
    var pluginIcon: UIImage? {
        return UIImage(named: "zxkit")
    }

    var pluginTitle: String {
        return "插件标题"
    }

    var pluginType: ZXKitPluginType {
        return .ui
    }

    func start() {
        print("点击启动该插件")
    }
}
```

## 3、注册插件

之后注册插件即可，全局只需注册一次，多次注册会导致重复显示

```
//注册插件
ZXKit.regist(plugin: PluginDemo())
```

## 4、完成

cocoapods发布上线之后，当用户打开`ZXKit`时，调试集合页就会出现您的插件

## 5、更多属性

### 5.1、悬浮的按钮

```
ZXKit.floatButton
```

## 二、消息通知

`ZXKitCore`提供了以下消息通知，您可以通过绑定以下通知获取框架显示、隐藏、关闭、注册新插件的时机

```
//注册新插件
NSNotification.Name. ZXKitPluginRegist
//显示
NSNotification.Name. ZXKitShow
//隐藏
NSNotification.Name. ZXKitHide
//关闭
NSNotification.Name. ZXKitClose
```

## 默认安装

我们会不时收录优秀的调试库，当用户执行安装`ZXKitSwift`时，会默认安装。如您想收录将插件收录到`ZXKitSwift`默认的集成库中，首先确认您没有使用`iOS`私有函数等影响App Store上架的违规因素，然后可以在[ZXKitSwift](https://github.com/ZXKitCode/ZXKitSwift)通知我们即可


## License

![](https://camo.githubusercontent.com/eb9066a6d8e0950066f3757c420e3a607c0929583b48ebda6fd9a6f50ccfc8f1/68747470733a2f2f7777772e6170616368652e6f72672f696d672f41534632307468416e6e69766572736172792e6a7067)

Base on Apache-2.0 License