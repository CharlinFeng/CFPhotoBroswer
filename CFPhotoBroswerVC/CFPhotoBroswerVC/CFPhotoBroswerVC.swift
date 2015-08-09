//
//  CFPhotoBroswerVC.swift
//  CFPhotoBroswerVC
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class CFPhotoBroswerVC: UIViewController {
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: Layout())

    /**  展示样式：请设置  */
    var showType: ShowType!
    
    /**  相册类型：请设置  */
    var photoType: PhotoType!
    
    /**  相册数据  */
    var dataModels: [PhotoModel]!{didSet{collectionView.reloadData()}}
    
    /**  强制关闭一切信息显示: 仅仅针对ZoomAndDismissWithSingleTap模式有效  */
    var hideMsgForZoomAndDismissWithSingleTap: Bool = false
    
    
    var page: Int = 0
    
    weak var vc: UIViewController!
    
    var isNavBarHidden: Bool!
    var isTabBarHidden: Bool!
    
    var showIndex: Int = 0
    
    
    var dismissBtn: UIButton!
    var isHiddenBar: Bool = false

    
}
