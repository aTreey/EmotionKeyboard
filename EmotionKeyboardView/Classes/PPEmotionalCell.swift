
//
//  PPEmotionalCell.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/10.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalCell: UICollectionViewCell {
    
    lazy var emojButtons = [PPEmotionalButton]()
    
    var indexPath: IndexPath! {
        
        // oldValue
        willSet {
            
        }
        
        // newValue
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
                button.emotionalModel = emotional
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        for i in 0..<kEmotional_count {
            let button = PPEmotionalButton()
            button.delegate = self
            addSubview(button)
            let row = i / kEmotional_column
            let column = i % kEmotional_column

            let width = (kScreen_Width - 2 * kEmotionalButton_margin) / CGFloat(kEmotional_column)
            let height = (bounds.height - 2 * kEmotionalButton_margin - CGFloat(kPPEmotionalKeyboardView_Bottom_Height)) / CGFloat(kEmotional_row)
            
            let x = kEmotionalButton_margin + CGFloat(column) * width
            let y = kEmotionalButton_margin + CGFloat(row) * height
            button.frame = CGRect(x: x, y: y, width: width, height: height)
            emojButtons.append(button)
        }
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


//MARK: 键盘中表情按钮点击和长安
extension PPEmotionalCell: PPEmotionalButtonDelegate {
    
    func longGestureRecoginzer(button: PPEmotionalButton, longGesture: UILongPressGestureRecognizer) {
        let currentPoint = longGesture.location(in: contentView)
        var tempButton: PPEmotionalButton?
        for button in emojButtons {
            if button.frame.contains(currentPoint) {
                tempButton = button
            }
        }
        
        if longGesture.state == UIGestureRecognizerState.began ||
            longGesture.state == UIGestureRecognizerState.changed {
            guard let btn = tempButton else { return }
            let index = emojButtons.index(of: btn)
            let emojiModel = emotionalModelArray![index!]
            if emojiModel.isEmpty || emojiModel.isDelete {
                popView.isHidden = true
                return
            }
            popView.show(fromButton: btn, emotional: emojiModel)
        }
    }
    
    
    func emojButtonAction(button: PPEmotionalButton) {
        let index = emojButtons.index(of: button)
        let emojiModel = emotionalModelArray![index!]
        if emojiModel.isEmpty || emojiModel.isDelete {
            popView.isHidden = true
        }
        popView.show(fromButton: button, emotional: emojiModel)
        popView.dismiss()

        // 发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kEmotionalNotificationName), object: emojiModel)
    }
}






