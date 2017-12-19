//
//  PPEmotionalButton.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/12/19.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit


protocol PPEmotionalButtonDelegate: NSObjectProtocol {
    func longGestureRecoginzer(button: PPEmotionalButton, longGesture: UILongPressGestureRecognizer)
    func emojButtonAction(button: PPEmotionalButton)
}



class PPEmotionalButton: UIButton {
    
    weak var delegate: PPEmotionalButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel?.font = UIFont.systemFont(ofSize: 32)
        backgroundColor = UIColor.white
        addTarget(self, action: #selector(emojButtonAction), for: .touchUpInside)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureRecoginzer))
        addGestureRecognizer(longGesture)
    }
    
    
    @objc private func longGestureRecoginzer(longGesture: UILongPressGestureRecognizer) {
        delegate?.longGestureRecoginzer(button: self, longGesture: longGesture)
    }
    
    @objc private func emojButtonAction() {
        delegate?.emojButtonAction(button: self)
    }
    
    var emotionalModel: PPEmotionalModel? {
        
        willSet {
            
        }
        
        didSet {
            // 使用contentOfFile 加载本地图片
            //            button.setImage(UIImage(named: emotional.imagePath ?? ""), for: .normal)
            setImage(UIImage(contentsOfFile: emotionalModel?.imagePath ?? ""), for: .normal)
            setTitle(emotionalModel?.code?.hexString2EmojString() ?? "", for: .normal)
            
            if let emotionalModel = emotionalModel,
                emotionalModel.isDelete {
                setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
        }
    }

}
