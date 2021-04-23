//
//  ZXKitPluginCollectionViewCell.swift
//  ZXKit
//
//  Created by Damon on 2021/4/23.
//

import UIKit
import SnapKit

class ZXKitPluginCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createUI() {
        self.contentView.addSubview(mImageView)
        mImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(46)
        }

        self.contentView.addSubview(mTitleLabel)
        mTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(mImageView.snp.bottom).offset(10)
        }
    }

    func updateUI(plugin: ZXKitPluginProtocol) {
        mImageView.image = plugin.pluginIcon
        mTitleLabel.text = plugin.pluginTitle
    }

    //MARK: UI
    lazy var mImageView: UIImageView = {
        let tImageView = UIImageView()
        tImageView.backgroundColor = UIColor(displayP3Red: 62.0/255.0, green: 183.0/255.0, blue: 142.0/255.0, alpha: 1.0)
        tImageView.layer.masksToBounds = true
        tImageView.layer.cornerRadius = 10
        return tImageView
    }()

    lazy var mTitleLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.numberOfLines = 2
        tLabel.textAlignment = .center
        tLabel.font = .systemFont(ofSize: 14)
        tLabel.textColor = UIColor.black
        return tLabel
    }()
}
