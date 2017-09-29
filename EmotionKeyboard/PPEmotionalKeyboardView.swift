//
//  PPEmotionalKeyboardView.swift
//  EmotionKeyboard
//
//  Created by Hongpeng Yu on 2017/9/29.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalKeyboardView: UIView {

    override init(frame: CGRect) {
        let rect = CGRect(x: 0, y: 0, width: 100, height: kPPEmotionalKeyboardView_Height)
        super.init(frame: rect)
        self.backgroundColor = UIColor.lightGray
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(bottomToobar)
        bottomToobar.frame = CGRect(x: 0, y: kPPEmotionalKeyboardView_Height - kPPEmotionalKeyboardView_BottomToobar_Height, width: Int(kScreen_Width), height: kPPEmotionalKeyboardView_BottomToobar_Height)
    }
    
    
    private lazy var bottomToobar: PPEmotionalToolbar = PPEmotionalToolbar()

}
