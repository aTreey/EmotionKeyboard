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
    
    @objc var isDelete = false
    
    @objc var isEmpty = false
    
    init(id: String, dict: [String: String]) {
        self.id = id
        super.init()
        setValuesForKeys(dict)
    }
    
    init(isDelete: Bool) {
        super.init()
        self.isDelete = isDelete
    }
    
    init(isEmpty: Bool) {
        super.init()
        self.isEmpty = isEmpty
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {    }
    
    override var description: String {
        let keys = ["chs", "code", "code", "type"]
        let dict = self.dictionaryWithValues(forKeys: keys)
        return dict.description
    }
}
