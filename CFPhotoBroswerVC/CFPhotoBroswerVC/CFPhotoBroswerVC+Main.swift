//
//  CFPhotoBroswerVC+Main.swift
//  CFPhotoBroswerVC
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


extension CFPhotoBroswerVC{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**  准备  */
        collectionViewPrepare()
        
        /**  控制器准备  */
        vcPrepare()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        view.backgroundColor = UIColor.blackColor()
    }
    
    /**  控制器准备  */
    func vcPrepare(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "singleTapAction", name: CFPBSingleTapNofi, object: nil)
    
        if showType != CFPhotoBroswerVC.ShowType.ZoomAndDismissWithSingleTap {
            
            dismissBtn = UIButton(frame: CGRectMake(0, 0, 40, 40))
            dismissBtn.setBackgroundImage(UIImage(named: "pic.bundle/close"), forState: UIControlState.Normal)
            dismissBtn.addTarget(self, action: "dismissPrepare", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(dismissBtn)
        }
    }
    
    
    /**  单击事件  */
    func singleTapAction(){
        
        if showType != CFPhotoBroswerVC.ShowType.ZoomAndDismissWithSingleTap {
        
            isHiddenBar = !isHiddenBar
            
            dismissBtn.hidden = isHiddenBar
            
            //取出cell
            let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! ItemCell
            cell.toggleDisplayBottomBar(isHiddenBar)
            
        }else{
           
            dismissPrepare()
        }
        
        
    }
    
    
    func dismissAction(isZoomType: Bool){
        
        if vc.navigationController != nil {vc.navigationController?.navigationBarHidden = isNavBarHidden}
        if vc.tabBarController != nil {vc.tabBarController?.tabBar.hidden = isTabBarHidden}
        
        if !isZoomType {return}
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    
    func dismissPrepare(){
        
        if showType == .Push{
            
            self.navigationController?.popViewControllerAnimated(true)
            
            dismissAction(false)
            
        }else if showType == .Modal{
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            dismissAction(false)
            
        } else if showType == ShowType.ZoomAndDismissWithSingleTap{
            
            dismissAction(true)
            
        }else{
            
            dismissAction(true)
        }
        
        

    }
    
    func show(inVC vc: UIViewController,index: Int){
        
        assert(showType != nil, "Error: You Must Set showType!")
        assert(photoType != nil, "Error: You Must Set photoType!")
        assert(dataModels != nil, "Error: You Must Set DataModels!")
        assert(index <= dataModels.count - 1, "Error: Index is Out of DataModels' Boundary!")
        //记录index
        showIndex = index
        
        //记录
        self.vc = vc
        
        
        let navVC = vc.navigationController
        
        if vc.navigationController != nil { isNavBarHidden = vc.navigationController?.navigationBarHidden}
        if vc.tabBarController != nil { isTabBarHidden = vc.tabBarController?.tabBar.hidden}
        
        navVC?.navigationBarHidden = true
        vc.tabBarController?.tabBar.hidden = true
        
        
        if showType == .Push{//push
            vc.hidesBottomBarWhenPushed = true
            vc.navigationController?.pushViewController(self, animated: true)
            
        }else if showType == .Modal{
            
            vc.presentViewController(self, animated: true, completion: nil)
            
        }else{
            
            //添加子控制器
            vc.view.addSubview(self.view)
            
            //添加约束
            self.view.cf_snp_4Insets(UIEdgeInsetsZero)
            
            vc.addChildViewController(self)
        }
    }
    
}