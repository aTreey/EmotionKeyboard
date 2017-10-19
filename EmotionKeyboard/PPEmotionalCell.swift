
//
//  PPEmotionalCell.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/10.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalCell: UICollectionViewCell {
    
    lazy var emojButtons = [UIButton]()
    
    /// 每页对应的模型数组
    var emotionalModelArray: [PPEmotionalModel]? {
        didSet {
            for (index, emotional) in (emotionalModelArray?.enumerated())! {
                let button = emojButtons[index]
                let image = UIImage(contentsOfFile: emotional.png!)
                button.setImage(UIImage(named: emotional.imagePath!), for: .normal)
            }
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
//        contentView.addSubview(label)
//        label.center = CGPoint(x: contentView.center.x, y: contentView.center.y)
        
        for i in 0..<kEmeotional_count {
            let button = UIButton(type: .custom)
            addSubview(button)
            let row = i / kEmeotional_column
            let column = i % kEmeotional_column

            let width = (kScreen_Width - 2 * kEmeotionalButton_margin) / CGFloat(kEmeotional_column)
            let height = (bounds.height - 2 * kEmeotionalButton_margin) / CGFloat(kEmeotional_row)
            
            let x = kEmeotionalButton_margin + CGFloat(column) * width
            let y = kEmeotionalButton_margin + CGFloat(row) * height
            
            button.frame = CGRect(x: x, y: y, width: width, height: height)
            button.backgroundColor = UIColor.white
            button.addTarget(self, action: #selector(emojButtonAction), for: .touchUpInside)
            emojButtons.append(button)
        }
    }
    
    
    @objc private func emojButtonAction() {
        print("选中表情")
    }
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightText
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
}
