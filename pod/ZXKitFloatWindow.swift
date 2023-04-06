//
//  ZXKitFloatWindow.swift
//  ZXKit
//
//  Created by Damon on 2021/4/25.
//

import UIKit
import ZXKitUtil

enum ZXFloatMenuStatus {
    case collapsed
    case open
    case info(config: ZXKitButtonConfig)
}

class ZXKitFloatWindow: UIWindow {
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("icon_search", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("notifications-btn", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("settings-btn", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
        ("nearby-btn", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1))
    ]

    var menuStatus: ZXFloatMenuStatus = .collapsed {
        didSet {
            switch menuStatus {
                case .collapsed:
                    mButton.setImage(UIImage(named: "zx_logo_a"), for: .normal)
                    mButton.setTitle(nil, for: UIControl.State.normal)
                    mButton.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: .bold)
                    self.bounds.size.width = 60
                    self.bounds.size.height = 60
                case .open:
                    mButton.setImage(UIImage(named: "zx_logo_a"), for: .normal)
                    mButton.setTitle(nil, for: UIControl.State.normal)
                    mButton.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: .bold)
                    self.bounds.size.width = 240
                    self.bounds.size.height = 240
                case .info(let config):
                    mButton.setImage(nil, for: .normal)
                    mButton.setTitle(config.title, for: .normal)
                    mButton.setTitleColor(config.titleColor, for: .normal)
                    mButton.titleLabel?.font = config.titleFont
                    mButton.backgroundColor = config.backgroundColor ?? ZXKit.UIConfig.floatButtonColor
                    self.bounds.size.width = 60
                    self.bounds.size.height = 60
            }
            self._resetPosition()
        }
    }


    @available(iOS 13.0, *)
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        self._initVC()
        self._createUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initVC()
        self._createUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var mButton: CircleMenu = {
        let button = CircleMenu(
            frame: CGRect(x: 0, y: 0, width: 60, height: 60),
            normalIcon:"zx_logo_a",
            selectedIcon:"zx_logo_a",
            buttonsCount: 4,
            duration: 2,
            distance: 120)
        button.delegate = self
        button.zx.addLayerShadow(color: UIColor.zx.color(hexValue: 0x333333), offset: CGSize(width: 2, height: 2), radius: 4, cornerRadius: 30)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(_touchMove(p:)))
        button.addGestureRecognizer(pan)
        return button
    }()


}

extension ZXKitFloatWindow {

}

private extension ZXKitFloatWindow {
    func _initVC() {
        self.rootViewController = UIViewController()
        self.windowLevel =  UIWindow.Level.alert
        self.isUserInteractionEnabled = true
    }

    @objc func _show() {
        ZXKit.show()
    }

    func _createUI() {
        guard let rootViewController = self.rootViewController else {
            return
        }

        rootViewController.view.addSubview(mButton)
        mButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(60)
        }
    }

    @objc func _touchMove(p:UIPanGestureRecognizer) {
        guard let window = ZXKitUtil.shared.getCurrentNormalWindow() else { return }
        let panPoint = p.location(in: window)
        //跟随手指拖拽
        if p.state == .changed {
            self.center = CGPoint(x: panPoint.x, y: panPoint.y)
            p.setTranslation(CGPoint.zero, in: self)
        }
        //弹回边界
        print(panPoint.x, panPoint.y, self.center.x, self.center.y)
        if p.state == .ended || p.state == .cancelled {
            self._resetPosition()
            p.setTranslation(CGPoint.zero, in: self)
        }
    }

    func _resetPosition() {
        guard let window = ZXKitUtil.shared.getCurrentNormalWindow() else { return }
        var x: CGFloat = 50
        if self.center.x > (window.bounds.size.width) / 2.0 {
            switch self.menuStatus {
                case .open:
                    x = window.bounds.size.width - 150
                default:
                    x = window.bounds.size.width - 50
            }
        } else {
            switch self.menuStatus {
                case .open:
                    x = 150
                default:
                    x = 50
            }
        }
        let y = min(max(130, self.center.y), window.bounds.size.height - 140)
        UIView.animate(withDuration: 0.35) {
            self.center = CGPoint(x: x, y: y)
        }
    }
}

extension ZXKitFloatWindow: CircleMenuDelegate {
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color

        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)

        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }

    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }

    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }

    func menuCollapsed(_ circleMenu: CircleMenu) {
        self.menuStatus = .collapsed
    }

    func menuOpened(_ circleMenu: CircleMenu) {
        self.menuStatus = .open
    }
}
