//
//  ZXKitUIConfig.swift
//  ZXKitCore
//
//  Created by Damon on 2022/7/23.
//

import Foundation
import ZXKitUtil

public struct ZXKitUIConfig {
    var floatButtonColor = UIColor.zx.color(hexValue: 0x5dae8b)     //悬浮窗按钮颜色
    var collectionViewBackgroundColor = UIColor.zx.color(hexValue: 0xfcecdd, alpha: 0.93)
    var collectionViewTitleColor = UIColor.zx.color(hexValue: 0xffffff)
    var collectionViewTitleBackgroundColor = UIColor.zx.color(hexValue: 0x5dae8b)
    var inputBackgroundColor = UIColor.zx.color(hexValue: 0x000000, alpha: 0.7)
    var textFieldBackgroundColor = UIColor.zx.color(hexValue: 0xffffff, alpha: 0.8)
    var inputButtonBackgroundColor = UIColor.zx.color(hexValue: 0x5dae8b)
}

public struct ZXKitButtonConfig: Equatable {
    var title: String?
    var titleColor: UIColor = UIColor.zx.color(hexValue: 0xffffff)
    var titleFont: UIFont = UIFont.systemFont(ofSize: 13, weight: .bold)
    var backgroundColor: UIColor?

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.title == rhs.title && lhs.titleColor == rhs.titleColor && lhs.titleFont == rhs.titleFont && lhs.backgroundColor == rhs.backgroundColor
    }
}
