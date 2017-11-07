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
    
    
    ///  通过自定义NSTextAttachmnet 类绑定数据
    lazy var selectEmojis = [PPEmotionalModel]()
    
    var textStr: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.white
        
        textView.inputView = emotionalKeyboard
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(emojiButtonDidClick), name: Notification.Name(rawValue: kEmotionalNotificationName), object: nil)
        
    }
    
    
    @IBAction func composeAction(_ sender: Any) {
        
    }
    
    
    @IBAction func emoji2textAction(_ sender: Any) {
        
        var mutableString = String()
        
        /// 便利富文本的所有属性
        textView.attributedText.enumerateAttributes(in: NSRange(location: 0, length: textView.attributedText.length), options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired) { (dict, range, error) in
            
            if (dict[NSAttributedStringKey.attachment] is NSTextAttachment) {
                let attachment = dict[NSAttributedStringKey.attachment] as? PPTextAttachment
                mutableString += (attachment?.chs) ?? ""
            } else {
//                let subStr = textView.text[textView.text.startIndex..<textView.text.endIndex]
                let subString = (textView.text as NSString?)?.substring(with: range)
                mutableString += subString!
            }
        }
        
        textStr = mutableString
        print(mutableString)
        
        /// 便利指定的富文本属性
        textView.attributedText.enumerateAttribute(NSAttributedStringKey.attachment, in: NSRange(location: 0, length: textView.attributedText.length), options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired) { (any, range, error) in
            if any is NSTextAttachment {
//                print("2222是富文本")
            } else {
//                print("2222正常文本")
            }
        }
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
        
        // 点击的是emoji表情
        if let emoji = emoji.code {
            textView.replace(textView.selectedTextRange!, withText: emoji.hexString2EmojString())
            return
        }
        
        // 图片表情
        let emojiImage = PPTextAttachment()
        let lineHeight = textView.font!.lineHeight
        emojiImage.bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
        emojiImage.image = UIImage(contentsOfFile: emoji.imagePath ?? "")
        emojiImage.chs = emoji.chs
        
        // 设置attachment 图片附件的字体高度，需要变为mutable类型
        let mutableAttachmentText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: emojiImage))
        
        let attrsDict = [NSAttributedStringKey.font : textView.font!]
        mutableAttachmentText.addAttributes(attrsDict, range: NSRange(location: 0, length: 1))

        let attributeStr = NSMutableAttributedString(attributedString: textView.attributedText)
        
        
        let range = textView.selectedRange
        attributeStr.replaceCharacters(in: range, with: mutableAttachmentText)
        textView.attributedText = attributeStr
        
        // 恢复光标的选中位置
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

