//
//  PPTextAttachment.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/11/2.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPTextAttachment: NSTextAttachment {
    // 中文表情
    var chs: String?
    
    /// 将表情图片转换为表情文字
    class func emotional2ImageText(emotional: PPEmotionalModel, font: UIFont) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(contentsOfFile:emotional.imagePath ?? "")
        attachment.bounds = CGRect(x: 0, y: -5, width: font.lineHeight, height: font.lineHeight)
        return NSAttributedString(attachment: attachment)
    }
}
