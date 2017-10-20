
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
    
    var indexPath: IndexPath! {
        didSet {
//            label.text = "\(indexPath.section) -- \(indexPath.row)"
        }
    }
    
    
    /// 每页对应的模型数组
    var emotionalModelArray: [PPEmotionalModel]? {
        didSet {
            for (index, emotional) in (emotionalModelArray?.enumerated())! {
                let button = emojButtons[index]
                button.isHidden = false
                // 使用contentOfFile 加载本地图片
//                button.setImage(UIImage(named: emotional.imagePath ?? ""), for: .normal)
                button.setImage(UIImage(contentsOfFile: emotional.imagePath ?? ""), for: .normal)
                button.setTitle(emotional.code?.hexString2EmojString() ?? "", for: .normal)
                button.setTitleColor(.blue, for: .normal)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
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
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            button.backgroundColor = UIColor.white
            button.addTarget(self, action: #selector(emojButtonAction), for: .touchUpInside)
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureRecoginzer))
            button.addGestureRecognizer(longGesture)
            
            emojButtons.append(button)
        }
        
//        testLabel()
        
    }
    
    @objc private func longGestureRecoginzer() {
        popView.show()
        print("长按")

    }
    
    @objc private func emojButtonAction() {
        print("选中")
    }
    
    
    private func testLabel() {
        contentView.addSubview(label)
        label.center = CGPoint(x: contentView.center.x, y: contentView.center.y)
    }
    
    
    private lazy var popView = PPEmotionalPopView()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 30, width: 100, height: 50)
        label.textColor = UIColor.purple
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
}
