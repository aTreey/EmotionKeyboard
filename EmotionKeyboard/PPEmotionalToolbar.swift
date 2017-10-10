//
//  PPEmotionalToolbar.swift
//  EmotionKeyboard
//
//  Created by Hongpeng Yu on 2017/9/29.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit


protocol PPEmotionalToolbarDelegate : NSObjectProtocol {
    func toolbar(_ toobar: PPEmotionalToolbar, didSelectButtonAt index: Int)
}

@available(iOS 9.0, *)
class PPEmotionalToolbar: UIStackView {
    var buttons = [UIButton]()
    var selectedButton: UIButton?
    weak open var delegate: PPEmotionalToolbarDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = UILayoutConstraintAxis.horizontal
        distribution = UIStackViewDistribution.fillEqually
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        addEmotional()
    }
    
    
    @objc private func buttonDidselect(button: UIButton) {
        selectedButton?.isSelected = false
        selectedButton = button
        button.isSelected = true
        let index = buttons.index(of: button)
        delegate?.toolbar(self, didSelectButtonAt: index!)
    }
    
    private func addEmotional() {
        let buttonInfo = [["title": "默认", "imageName": "button1"],
                          ["title": "表情", "imageName": "button1"],
                          ["title": "下载", "imageName": "button1"]]
        
        for (index, info) in buttonInfo.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(info["title"], for: .normal)
            button.setTitleColor(UIColor.lightText, for: .normal)
            button.setTitleColor(UIColor.blue, for: .selected)
            button.setBackgroundImage(UIImage(named: "imageName"), for: .normal)
            button.backgroundColor = UIColor.lightGray
            button.addTarget(self, action: #selector(PPEmotionalToolbar.buttonDidselect(button:)), for: .touchUpInside)
            button.isSelected = index == 0
            if 0 == index {
                selectedButton = button
            }
            buttons.append(button)
            addArrangedSubview(button)
        }
        
    }
}
