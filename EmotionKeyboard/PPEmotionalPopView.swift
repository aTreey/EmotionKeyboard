//
//  PPEmotionalPopView.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/20.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalPopView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setup() {
        addSubview(imageView)
        addSubview(button)
    }
    
    func show() {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        
    }
    
    private lazy var imageView = UIImageView(image: UIImage(named: "emoticon_keyboard_magnifier"))
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        let width = self.imageView.bounds.width * 0.8
        button.frame = CGRect(x: 0, y: 0, width: width, height: width)
        button.setTitle("pop", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
}
