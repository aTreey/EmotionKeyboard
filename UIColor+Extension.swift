//
//  UIcolor+Extension.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/10.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

extension UIColor {
    class var randomColor: UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
