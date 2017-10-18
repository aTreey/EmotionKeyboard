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
    
    // 构造函数如果定义了必选属性，必须通过构造函数为这些必选属性分配空间并且设置初始值
   //  非 Optional 属性，都必须在构造函数中设置初始值，从而保证对象在被实例化的时候，属性都被正确初始化
    // 在调用父类构造函数之前，必须保证本类的属性都已经完成初始化
    // 
    init(name: String, packages: [[String : String]]) {
        self.emojiName = name
        super.init()
        var tempArray = [PPEmotionalModel]()
        for item in packages {
            let emoj = PPEmotionalModel(dict: item)
            tempArray.append(emoj)
        }
    }
    
//    convenience:便利，使用convenience修饰的构造函数叫做便利构造函数
//    便利构造函数通常用在对系统的类进行构造函数的扩充时使用。
//    便利构造函数的特点：
//    1、便利构造函数通常都是写在extension里面
//    2、便利函数init前面需要加载convenience
//    3、在便利构造函数中需要明确的调用self.init()
    
}
