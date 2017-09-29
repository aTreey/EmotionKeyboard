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
        
        view.backgroundColor = UIColor.black
        
        textView.inputView = emotionalKeyboard
        
        
    }
    
    
    private lazy var emotionalKeyboard: PPEmotionalKeyboardView = PPEmotionalKeyboardView()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

