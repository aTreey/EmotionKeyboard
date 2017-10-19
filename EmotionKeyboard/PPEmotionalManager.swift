//
//  PPEmotionalManager.swift
//  EmotionKeyboard
//
//  Created by HongpengYu on 2017/10/18.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalManager: NSObject {
    
    // 定义packges数组
    lazy var packages = [PPEmotionalPackage]()
    
    override init() {
        super.init()
        loadEmotionals()
    }
    
    func loadEmotionals() {
        // 先加载bundle 然后加载数据
//        let bundlePath = Bundle.main.path(forResource: "Emoticons", ofType: "bundle")
//        let bundle = Bundle(path: bundlePath!)
//        let plistPath = bundle?.path(forResource: "emoticons", ofType: "plist")
//        let dict1 = NSDictionary(contentsOfFile: plistPath!)
        
        // 直接加载
        let path = Bundle.main.path(forResource: "emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        let dict = NSDictionary(contentsOfFile: path)!
        let packages = dict["packages"] as! [[String:AnyObject]]
        
        for section in packages {
            let id = section["id"] as! String
            loadSectionEmotional(id: id)
        }
    }
    
    private func loadSectionEmotional(id: String) {
        let infoPlistPath = Bundle.main.path(forResource: "info", ofType: "plist", inDirectory: "Emoticons.bundle/" + id)!
        let dict = NSDictionary(contentsOfFile: infoPlistPath)!
        let emojName = dict["group_name_cn"] as! String
        
        // 数组中字典是[string : string]
        let packageArray = dict["emoticons"] as! [[String : String]]
        
        let package = PPEmotionalPackage(id: id, name: emojName, packages: packageArray)
        packages.append(package)
    }
}
