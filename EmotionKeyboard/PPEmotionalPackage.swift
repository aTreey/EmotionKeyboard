//
//  PPEmotionalPackage.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/18.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalPackage: NSObject {
    var emojiName: String?
    
    lazy var sectionArray = [[PPEmotionalModel]]()
    // 构造函数如果定义了必选属性，必须通过构造函数为这些必选属性分配空间并且设置初始值
   //  非 Optional 属性，都必须在构造函数中设置初始值，从而保证对象在被实例化的时候，属性都被正确初始化
    // 在调用父类构造函数之前，必须保证本类的属性都已经完成初始化
    // 
    init(id: String, name: String, packages: [[String : String]]) {
        self.emojiName = name
        super.init()
        var tempArray = [PPEmotionalModel]()
        var count = 0
        for item in packages {
            count += 1
            let emoj = PPEmotionalModel(id: id, dict: item)
            tempArray.append(emoj)
            if count == kEmotional_count - 1 {
                count = 0
                let deleteModel = PPEmotionalModel(isDelete: true)
                tempArray.append(deleteModel)
            }
        }
        
        // 添加空模型
        let residue = tempArray.count % kEmotional_count
        if residue > 0 {
            for _ in residue..<kEmotional_count - 1  {
                let emptyModel = PPEmotionalModel(isEmpty: true)
                tempArray.append(emptyModel)
            }
            
            let deleteModel = PPEmotionalModel(isDelete: true)
            tempArray.append(deleteModel)
        }
        sectionArray = parseSectionEmotionals(array: tempArray)
    }
    
//    convenience:便利构造函数
//    便利构造函数通常用在对系统的类进行构造函数的扩充时使用。
//    便利构造函数的特点：
//    1、便利构造函数通常都是写在extension里面
//    2、便利函数init前面需要加载convenience
//    3、在便利构造函数中需要明确的调用self.init()
    
    
    
    
    // MARK: 处理 [PPEmotionalModel] 类型的数据
    private func parseSectionEmotionals(array: [PPEmotionalModel]) -> [[PPEmotionalModel]] {
        var sectionArray = [[PPEmotionalModel]]()
        
        let page = Double(array.count) / Double(kEmotional_count)
        let pageCount = Int(ceil(page))
        
        for i in 0..<pageCount {
            let loc = i * kEmotional_count
            var length = kEmotional_count
            
            if loc + length > array.count {
                length = array.count - loc
            }
            
            let range = NSMakeRange(loc, length)
            let subArray = array as NSArray
            let tempArray = subArray.subarray(with: range)
            sectionArray.append(tempArray as! [PPEmotionalModel])
        }
        return sectionArray
    }
    
    
}
