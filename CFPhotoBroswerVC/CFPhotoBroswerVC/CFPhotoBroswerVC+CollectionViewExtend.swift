//
//  CFPhotoBroswerVC+CollectionView.swift
//  CFPhotoBroswerVC
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


extension CFPhotoBroswerVC: UICollectionViewDataSource,UICollectionViewDelegate{
    

    
    var cellID: String {return "ItemCell"}
    

    override func viewDidAppear(animated: Bool) {

        collectionView.hidden = false
        super.viewDidAppear(animated)
        self.handleRotation(false)
        
        let isZoomType = self.showType == CFPhotoBroswerVC.ShowType.ZoomAndDismissWithCancelBtnClick || self.showType == CFPhotoBroswerVC.ShowType.ZoomAndDismissWithSingleTap
        
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: showIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: !isZoomType)
    }

    
    /**  准备  */
    func collectionViewPrepare(){
        
        //添加
        self.view.addSubview(collectionView)
        collectionView.cf_snp_4Insets(UIEdgeInsetsMake(0, 0, 0, -CFPBExtraWidth))

        //注册cell
        collectionView.registerNib(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.pagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        let isZoomType = self.showType == CFPhotoBroswerVC.ShowType.ZoomAndDismissWithCancelBtnClick || self.showType == CFPhotoBroswerVC.ShowType.ZoomAndDismissWithSingleTap
        
        if isZoomType {
            collectionView.hidden = true
        }
    }

    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let itemCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! ItemCell
 
        itemCell.photoType = photoType
        
        itemCell.isHiddenBar = isHiddenBar
        
        itemCell.dataModel = dataModels[indexPath.row]
        
        itemCell.countLabel.text = "\(indexPath.row + 1) / \(dataModels.count)"
        
        if hideMsgForZoomAndDismissWithSingleTap && showType == .ZoomAndDismissWithSingleTap {itemCell.toggleDisplayBottomBar(true)}
        
        return itemCell
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let itemCell = cell as! ItemCell
        
        itemCell.reset()
    }
    
    
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        handleRotation(false)
    }
    
    
    
    func handleRotation(anim: Bool){
        let layout = Layout()
        
        layout.itemSize = self.view.bounds.size.sizeWithExtraWidth
        collectionView.setCollectionViewLayout(layout, animated: anim)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
        
    }
    
}

