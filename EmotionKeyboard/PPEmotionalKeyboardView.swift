//
//  PPEmotionalKeyboardView.swift
//  EmotionKeyboard
//
//  Created by Hongpeng Yu on 2017/9/29.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalKeyboardView: UIView {

    override init(frame: CGRect) {
        let rect = CGRect(x: 0, y: 0, width: 100, height: kPPEmotionalKeyboardView_Height)
        super.init(frame: rect)
        self.backgroundColor = UIColor.cyan
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        if #available(iOS 9.0, *) {
            addSubview(bottomToobar)
            bottomToobar.frame = CGRect(x: 0, y: kPPEmotionalKeyboardView_Height - kPPEmotionalKeyboardView_BottomToobar_Height - 34, width: Int(kScreen_Width), height: kPPEmotionalKeyboardView_BottomToobar_Height)
        } else {
            // Fallback on earlier versions
        }
        
        addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPPEmotionalKeyboardView_emotionalCell)
    }
    
    
    
    private lazy var collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 0, width: kScreen_Width, height: self.bounds.height - 34 - bottomToobar.bounds.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: kScreen_Width, height: rect.height)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.yellow
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    @available(iOS 9.0, *)
    private lazy var bottomToobar: PPEmotionalToolbar = PPEmotionalToolbar()

}

extension PPEmotionalKeyboardView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPPEmotionalKeyboardView_emotionalCell, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor
        return cell
    }
}
