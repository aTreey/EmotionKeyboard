//
//  ViewController.swift
//  EmotionKeyboard
//
//  Created by Hongpeng Yu on 2017/9/28.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.white
        
        textView.inputView = emotionalKeyboard
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(emojiButtonDidClick), name: Notification.Name(rawValue: kEmotionalNotificationName), object: nil)
        
    }
    
    
    @objc func emojiButtonDidClick(notice: Notification) {
        if let objc = notice.object as? PPEmotionalModel {
//            textView.replace(textView.selectedTextRange!, withText: objc.code?.hexString2EmojString() ?? "")
            insertEmoji(emoji: objc)
        }
    }
    
    func insertEmoji(emoji: PPEmotionalModel) {
        // 填充的空按钮
        if emoji.isEmpty {
            print("填充的空按钮,直接return")
            return
        }
        // 删除按钮
        if emoji.isDelete {
            textView.deleteBackward()
            print("删除按钮,删除字符")
            return
        }
        
        // 图片表情
        let emojiImage = NSTextAttachment()
        let lineHeight = textView.font!.lineHeight
        emojiImage.bounds = CGRect(x: 0, y: -5, width: lineHeight, height: lineHeight)
        emojiImage.image = UIImage(contentsOfFile: emoji.imagePath ?? "")
        
        // 设置attachment 图片附件的字体高度，需要变为mutable类型
        let attachmentText = NSAttributedString(attachment: emojiImage)
        let mutableAttachmentText = NSMutableAttributedString(attributedString: attachmentText)
        mutableAttachmentText.addAttribute(NSAttributedStringKey.font, value: textView.font!, range: NSRange(location: 0, length: 1))
        let attributeStr = NSMutableAttributedString(attributedString: textView.attributedText)
        let range = textView.selectedRange
        attributeStr.replaceCharacters(in: range, with: attachmentText)
        textView.attributedText = attributeStr
        textView.selectedRange = NSRange(location: range.location + 1, length: 0)
    }
    
    private lazy var emotionalKeyboard: PPEmotionalKeyboardView = PPEmotionalKeyboardView()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

