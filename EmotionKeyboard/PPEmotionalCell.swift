
//
//  PPEmotionalCell.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/10.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalCell: UICollectionViewCell {
    
    var indexPath: IndexPath? {
        didSet {
            label.text = "第\(indexPath!.section)组\(indexPath!.row)个"
            label.sizeToFit()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(label)
        label.center = CGPoint(x: contentView.center.x, y: contentView.center.y)
    }
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightText
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
}
