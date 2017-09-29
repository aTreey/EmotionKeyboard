//
//  PPEmotionalToolbar.swift
//  EmotionKeyboard
//
//  Created by Hongpeng Yu on 2017/9/29.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalToolbar: UIStackView {
    
    
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
    
    
    private func addEmotional() {
        let buttonInfo = [["title": "默认", "imageName": "button1"],
                          ["title": "表情", "imageName": "button1"],
                          ["title": "表情", "imageName": "button1"]]
        
        for info in buttonInfo {
            let button = UIButton(type: .custom)
            button.setTitle(info["title"], for: .normal)
            button.setTitleColor(UIColor.red, for: .normal)
            button.setBackgroundImage(UIImage(named: "imageName"), for: .normal)
            button.backgroundColor = UIColor.cyan
            addArrangedSubview(button)
        }
        
    }
}
