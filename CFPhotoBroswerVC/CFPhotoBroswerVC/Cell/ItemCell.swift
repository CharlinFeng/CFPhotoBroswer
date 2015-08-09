//
//  ItemCell.swift
//  CFPhotoBroswerVC
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    var dataModel: CFPhotoBroswerVC.PhotoModel!{didSet{dataFill()}}
    
    var photoType: CFPhotoBroswerVC.PhotoType!
    
    var isHiddenBar: Bool = true{didSet{toggleDisplayBottomBar(isHiddenBar)}}
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var bottomContentView: UIView!
    
    @IBOutlet weak var msgTitleLabel: UILabel!
    
    @IBOutlet weak var msgContentTextView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    lazy private var doubleTapGesture: UITapGestureRecognizer = {
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapGesture.numberOfTapsRequired = 2
        return doubleTapGesture
    }()
    
    lazy private var singleTapGesture: UITapGestureRecognizer = {
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: "singleTap:")
        singleTapGesture.numberOfTapsRequired = 1
        return singleTapGesture
    }()
    
}


extension ItemCell: UIScrollViewDelegate{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        singleTapGesture.requireGestureRecognizerToFail(doubleTapGesture)
        
        self.scrollView.addGestureRecognizer(doubleTapGesture)
        self.scrollView.addGestureRecognizer(singleTapGesture)
        scrollView.delegate = self
        
        msgContentTextView.textContainerInset = UIEdgeInsetsZero
        
    }
    
    func doubleTap(tapG: UITapGestureRecognizer){
        
        if scrollView.zoomScale <= 1 {
            
            let location = tapG.locationInView(tapG.view)
            
            let rect = CGRectMake(location.x, location.y, 10, 10)
            scrollView.zoomToRect(rect, animated: true)
            
        }else{
            
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func singleTap(tapG: UITapGestureRecognizer){
        
        NSNotificationCenter.defaultCenter().postNotificationName(CFPBSingleTapNofi, object: nil)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {return imageV}
    
    
    /**  复位  */
    func reset(){
        
        scrollView.setZoomScale(1, animated: false)
        msgContentTextView.setContentOffset(CGPointZero, animated: false)
    }
    
    /**  数据填充  */
    func dataFill(){
        
        if photoType == CFPhotoBroswerVC.PhotoType.Local {
            
            /**  本地图片模式  */
            /**  图片  */
            imageV.image = dataModel.localImg
            
            /**  标题  */
            if dataModel.titleStr != nil {msgTitleLabel.text = dataModel.titleStr}
            
            /**  内容  */
            if dataModel.descStr != nil {msgContentTextView.text = dataModel.descStr}
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
            Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {[unowned self] () -> Void in
                
                self.reset()
        }
    }
    
    func toggleDisplayBottomBar(isHidden: Bool){
        
        bottomContentView.hidden = isHidden
    }
}