//
//  String+Extension.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/20.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import Foundation

extension String {
    func hexString2EmojString() -> String {
        let scanner = Scanner(string: self)
        
        // 转换为16进制数
        var value: UInt64 = 0
        scanner.scanHexInt64(&value)
        let value2 = Int(value)
        let unicodo = Unicode.Scalar(value2)
        let char = Character(unicodo!)
        return "\(char)"
    }
}
