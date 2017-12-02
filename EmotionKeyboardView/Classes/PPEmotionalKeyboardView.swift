//
//  PPEmotionalKeyboardView.swift
//  EmotionKeyboard
//
//  Created by Hongpeng Yu on 2017/9/29.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

import UIKit

class PPEmotionalKeyboardView: UIView {

    var packages = PPEmotionalManager().packages
    
    override init(frame: CGRect) {
        let rect = CGRect(x: 0, y: 0, width: 0, height: kPPEmotionalKeyboardView_Height)
        super.init(frame: rect)
        self.backgroundColor = UIColor.yellow
        setupUI()
        
        let packages = PPEmotionalManager().packages
        print("packages = \(packages)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        if #available(iOS 9.0, *) {
            addSubview(bottomToobar)
            bottomToobar.frame = CGRect(x: 0, y: kPPEmotionalKeyboardView_Height - kPPEmotionalKeyboardView_BottomToobar_Height - 34, width: Int(kScreen_Width), height: kPPEmotionalKeyboardView_BottomToobar_Height)
            bottomToobar.delegate = self
        } else {
            // Fallback on earlier versions
        }
        
        
        addSubview(collectionView)
        addSubview(pageControl)
        
        let indexPath = NSIndexPath(index: 0)
        pageControl.numberOfPages = packages[indexPath.section].sectionArray.count
        pageControl.currentPage = 0
        pageControl.updateCurrentPageDisplay()
        collectionView.register(PPEmotionalCell.self, forCellWithReuseIdentifier: kPPEmotionalKeyboardView_emotionalCell)
    }
    
    
    
    private lazy var collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 0, width: kScreen_Width, height: self.bounds.height - 34 - bottomToobar.bounds.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: kScreen_Width, height: rect.height)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.lightText
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
//TODO: 点击pageControl 切换bug
    @objc private func didSelectItem(control: UIPageControl, event: UIEvent) {
        let touch = event.allTouches?.first
        let point = touch?.location(in: pageControl)
        let pageContorl_centerX = control.center.x
        let left = pageContorl_centerX - 15.0 * CGFloat(pageControl.numberOfPages) / 2
        let current_page = ((point?.x)! - left) / 15
        pageControl.currentPage = Int(current_page)
        
        collectionView.setContentOffset(CGPoint(x: pageControl.currentPage * Int(kScreen_Width), y: 0), animated: false)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.bounds.height  - 34 - bottomToobar.bounds.height - CGFloat(kPPEmotionalKeyboardView_Bottom_Height), width: 0, height: 30))
        pageControl.backgroundColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.addTarget(self, action: #selector(didSelectItem(control:event:)), for: .touchUpInside)
//        pageControl.defersCurrentPageDisplay = true
        return pageControl
    }()
    private lazy var bottomToobar: PPEmotionalToolbar = PPEmotionalToolbar()

}

//MARK: toobarDelegate
extension PPEmotionalKeyboardView : PPEmotionalToolbarDelegate {
    func toolbar(_ toobar: PPEmotionalToolbar, didSelectButtonAt index: Int) {
        print("index = \(index)")
        let indexPath = IndexPath(item: 0, section: index)

        // 水平方向滚动时
//         top
//         centeredVertically
//         bottom
        
        // 垂直方向滚动时
//      left
//      centeredHorizontally
//      right:
        
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
        
        pageControl.numberOfPages = PPEmotionalManager().packages[indexPath.section].sectionArray.count
        pageControl.currentPage = indexPath.item
//        pageControl.updateCurrentPageDisplay()
    }
}

//MARK: collectionViewDelegate, DataSource
extension PPEmotionalKeyboardView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return packages.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages[section].sectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPPEmotionalKeyboardView_emotionalCell, for: indexPath) as! PPEmotionalCell
        cell.emotionalModelArray = packages[indexPath.section].sectionArray[indexPath.item]
        cell.indexPath = indexPath
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = collectionView.indexPathsForVisibleItems.first!
//        print("index = \(index)")
        bottomToobar.setSelected(index: index.section)
        pageControl.numberOfPages = PPEmotionalManager().packages[index.section].sectionArray.count
        pageControl.currentPage = index.item
//        pageControl.updateCurrentPageDisplay()
    }
    
    /**
     动画结束时调用，必须是非人为拖拽的动画是
     */
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = collectionView.indexPathsForVisibleItems
        print("scrollViewDidEndScrollingAnimation---indexs = \(index)")
    }
    
    
    @objc func pageControlValueChange() {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        pageControl.updateCurrentPageDisplay()
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
        print(pageControl.currentPage)
    }
}
