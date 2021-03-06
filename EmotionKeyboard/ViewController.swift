//
//  ViewController.swift
//  EmotionKeyboard
//
//  Created by Hongpeng Yu on 2017/9/28.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    // 表情正则表达式对象 "\\[.*?\\]"
    static let emotianalRegx = try? NSRegularExpression(pattern: "\\[.*?\\]", options: [])
    // 话题正则表达式对象
    static let topicRegx = try? NSRegularExpression(pattern: "#.*?#", options: [])
    //@某人正则表达式对象
    static let atSomeOneRegex = try! NSRegularExpression(pattern: "@\\w+", options: [])
    
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
    
    
    /// 转化含有表情图片的字符串
    @IBAction func composeAction(_ sender: Any) {
        
        let attriString = NSMutableAttributedString(string: textView.text)
        
        
//        typedef NS_OPTIONS(NSUInteger, NSRegularExpressionOptions) {
//            NSRegularExpressionCaseInsensitive             = 1 << 0,     /*忽略大小写 */
//            NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1,     /* 忽略空格 */
//            NSRegularExpressionIgnoreMetacharacters        = 1 << 2,     /* Treat the entire pattern as a literal string. */
//            NSRegularExpressionDotMatchesLineSeparators    = 1 << 3,     /* 允许 . 匹配任意字符，包括任何分隔符 */
//            NSRegularExpressionAnchorsMatchLines           = 1 << 4,     /* 允许 ^ 和 $ . 匹配多行文本*/
//            NSRegularExpressionUseUnixLineSeparators       = 1 << 5,     /* 使用\n 作为换行符 */
//            NSRegularExpressionUseUnicodeWordBoundaries    = 1 << 6      /* 使用unicode 指定边界 */
//        };
        
        ///1.  枚举每一个符合的结果，在闭包中回调
//        emotianalRegx?.enumerateMatches(in: string, options: NSRegularExpressionCaseInsensitive, range: <#T##NSRange#>, using: { (result, <#NSRegularExpression.MatchingFlags#>, <#UnsafeMutablePointer<ObjCBool>#>) in
//
//        })
        
        /// 2. 返回第一符合的结果
//        emotianalRegx?.firstMatch(in: <#T##String#>, options: <#T##NSRegularExpression.MatchingOptions#>, range: <#T##NSRange#>)
        
        /// 3. 返回第一个符合的range
//        emotianalRegx?.rangeOfFirstMatch(in: <#T##String#>, options: <#T##NSRegularExpression.MatchingOptions#>, range: <#T##NSRange#>)
        
        ///4. 返回符合的集合
        let result = ViewController.emotianalRegx?.matches(in: textView.text, options: [], range: NSRange(location: 0, length: (textView.text?.count)!))
        
        for item in (result?.reversed())! {
            
            let range = item.range(at: 0)
            let subStr = (textView.text as NSString).substring(with: range)
            
//            print("subStr = \(subStr)")
            
            if let emotional = matchEmotion(with: subStr) {
                print("array = \(emotional)")
                let attachment = PPTextAttachment.emotional2ImageText(emotional: emotional, font: textView.font!)
                attriString.replaceCharacters(in: range, with: attachment)
            }
        }
        
        textView.attributedText = attriString.copy() as! NSAttributedString
        print(attriString)
    }
    
    
    func matchEmotion(with emotionText: String) -> PPEmotionalModel? {
        //获取分组
        for package in PPEmotionalManager().packages {
            // 获取表情数据
            for emotions in package.sectionArray {
                // 获取对应表情
                let array = emotions.filter({ (emotion) -> Bool in
                    return emotion.chs == emotionText
                })
                
                if !array.isEmpty {
                    return array.first
                }
            }
        }
        return nil
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
        
        
        let result = NSMutableAttributedString()
        
        result.append(textView.attributedText)
        result.append(NSAttributedString(string: "\n\n\n"))
        result.append(NSAttributedString(string: textStr!))
        
        textView.attributedText = result.copy() as! NSAttributedString
    
        
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

