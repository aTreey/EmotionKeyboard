//
//  PPEmotionalModel.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/19.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalModel: NSObject {
    
    /// 传给服务器时的表情文本
    var chs: String?
    
    /// 十六进制码
    var code: String?
    
    /// 图片
    var png: String?
    
    /// git
    var gif: String?
    
    /// 类型
    var type: String?
    
    init(dict: [String: String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {    }
    
    
}
