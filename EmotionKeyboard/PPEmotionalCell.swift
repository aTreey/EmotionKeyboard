
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
//            label.sizeToFit()
        }
    }
    
    
    //MARK: 处理模型,增加空model 和删除 model
    var emotionalModelArray: [PPEmotionalModel]? {
        didSet {
            
            for button in emojButtons {
                button.isHidden = true
            }
            for (index, emotional) in (emotionalModelArray?.enumerated())! {
                let button = emojButtons[index]
                button.isHidden = false
                // 使用contentOfFile 加载本地图片
//                button.setImage(UIImage(named: emotional.imagePath ?? ""), for: .normal)
                button.setImage(UIImage(contentsOfFile: emotional.imagePath ?? ""), for: .normal)
                button.setTitle(emotional.code?.hexString2EmojString() ?? "", for: .normal)
                if emotional.isDelete {
                    button.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
                }
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
        
        for i in 0..<kEmotional_count {
            let button = UIButton(type: .custom)
            addSubview(button)
            let row = i / kEmotional_column
            let column = i % kEmotional_column

            let width = (kScreen_Width - 2 * kEmotionalButton_margin) / CGFloat(kEmotional_column)
            let height = (bounds.height - 2 * kEmotionalButton_margin) / CGFloat(kEmotional_row)
            
            let x = kEmotionalButton_margin + CGFloat(column) * width
            let y = kEmotionalButton_margin + CGFloat(row) * height
            button.frame = CGRect(x: x, y: y, width: width, height: height)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            button.backgroundColor = UIColor.white
            button.addTarget(self, action: #selector(emojButtonAction), for: .touchUpInside)
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureRecoginzer))
            button.addGestureRecognizer(longGesture)
            
            emojButtons.append(button)
        }
        
//        testLabel()
        
    }
    
    //MARK: 长按手势
    @objc private func longGestureRecoginzer(gesture: UILongPressGestureRecognizer) {
        let currentPoint = gesture.location(in: contentView)
        var tempButton: UIButton?
        for button in emojButtons {
            if button.frame.contains(currentPoint) {
                tempButton = button
            }
        }
        
        if gesture.state == UIGestureRecognizerState.began ||
           gesture.state == UIGestureRecognizerState.changed {
            guard let btn = tempButton else { return }
            let index = emojButtons.index(of: btn)
            let emojiModel = emotionalModelArray![index!]
            if emojiModel.isEmpty || emojiModel.isDelete {
                popView.isHidden = true
                return
            }
            popView.show(fromButton: btn, emotional: emojiModel)
        } else {
            popView.isHidden = true
        }
    }
    

    //MARK: 点击Emoj按钮
    @objc private func emojButtonAction(button: UIButton) {
        let index = emojButtons.index(of: button)
        let emojiModel = emotionalModelArray![index!]
        if emojiModel.isEmpty || emojiModel.isDelete {
            popView.isHidden = true
            return
        }
        popView.show(fromButton: button, emotional: emojiModel)
        popView.dismiss()
        
        // 发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kEmotionalNotificationName), object: emojiModel)
    }
    
    //MARK: 通知
    
    
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
