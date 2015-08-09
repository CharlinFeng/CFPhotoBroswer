//
//  ViewController.swift
//  CFPhotoBroswerVC
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class LocalVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet var imageV: [UIImageView]!
}


extension LocalVC{
    
    
    @IBAction func tapImgV(sender: UITapGestureRecognizer) {
        
        let imageV = sender.view!
        
        self.show(imageV.tag)
    }
    
    
    func show(index: Int){
        
        
        let pbVC = CFPhotoBroswerVC()
        
        /**  设置相册展示样式  */
        pbVC.showType = CFPhotoBroswerVC.ShowType.ZoomAndDismissWithSingleTap
        
        /**  设置相册类型  */
        pbVC.photoType = CFPhotoBroswerVC.PhotoType.Local
        
        //强制关闭显示一切信息
        pbVC.hideMsgForZoomAndDismissWithSingleTap = true
        
        //模型数据数组
        let dm1 = CFPhotoBroswerVC.PhotoModel(localImg: UIImage(named: "1"), titleStr: "win 10 is beautiful", descStr: "Windows 10 is a new generation of cross platform and equipment used in the research and development of the Microsoft Corp.Within a year after the release of the official version, all eligible Windows7, Windows 8.1 and Phone Windows 8.1 users will be free to upgrade to Windows 10. All upgraded to Windows 10 of the devices, Microsoft will provide support for the permanent life cycle.Windows 10 is the last Windows version of Microsoft's release, the next generation Windows will be as Update[1] form. Windows10 will release 7 release versions, respectively, for different users and devices.",sourceImageView: imageV[0])
        
        let dm2 = CFPhotoBroswerVC.PhotoModel(localImg: UIImage(named: "2"), titleStr: "Star Meau", descStr: "The start menu is back in win10.",sourceImageView: imageV[1])
        
        let dm3 = CFPhotoBroswerVC.PhotoModel(localImg: UIImage(named: "3"), titleStr: "A variety of powerful and good-looking plug-in, a bit like IOS", descStr: "Still very good, looking forward to the rise of MAC",sourceImageView: imageV[2])
        
        /**  设置数据  */
        pbVC.dataModels = [dm1,dm2,dm3]
        
        pbVC.show(inVC: self,index: index)

    }
    
}

