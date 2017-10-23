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
        let rect = CGRect(x: 0, y: 0, width: kEmotionalPopView_width, height: kEmotionalPopView_height)
        super.init(frame: rect)
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setup() {
        addSubview(imageView)
        addSubview(button)
        
    }
    
    func show(fromButton button: UIButton!) {
        
        // 键盘的window不是keyWindow，获取keyWindow添加popView 会有问题
        let window = UIApplication.shared.windows.last
        window?.addSubview(self)
        self.isHidden = false
        let buttonRect = button.convert(button.bounds, to: window)
        center.x = buttonRect.midX;
        frame.origin.y = buttonRect.maxY - bounds.height
        
        /**
         0.5 s之后取消popView
         1. GCD 延迟执行
         2. perform延迟执行某一个方法
         */
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.isHidden = true
        }
        
//        perform(#selector(hidden), with: nil, afterDelay: 0.5)
    }
    
    
    @objc private func hidden() {
        isHidden = true
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
