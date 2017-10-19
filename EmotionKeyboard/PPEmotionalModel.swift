//
//  PPEmotionalModel.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/19.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalModel: NSObject {
    
    /// 表情包id
    @objc var id: String?
    
    /// 传给服务器时的表情文本
    @objc var chs: String?
    
    /// 十六进制码
    @objc var code: String?
    
    /// 图片
    @objc var png: String? {
        didSet {
            imagePath = Bundle.main.bundlePath + "/Emoticons.bundle/" + "\(id!)/" + "\(png ?? "")"
        }
//        return Bundle.main.bundlePath + "/Emoticons.bundle/" + "\(id!)/" + "\(png ?? "")"
    }
    
    @objc var imagePath: String?
    
    /// git
    @objc var gif: String?
    
    /// 类型
    @objc var type: String?
    
    init(id: String, dict: [String: String]) {
        self.id = id
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {    }
    
    
}
