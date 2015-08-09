//
//  CFPhotoBroserVC+Model.swift
//  CFPhotoBroswerVC
//
//  Created by 成林 on 15/8/10.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

extension CFPhotoBroswerVC{
    
    class PhotoModel{
        
        /**  本地相册模式下的本地相册数据  */
        var localImg: UIImage
        
        /**  标题  */
        var titleStr: String!
        
        /**  详细说明文字  */
        var descStr: String!
        
        /**  源ImageView: zoom模式需要传  */
        var sourceImageView: UIImageView!
        
        lazy var sourceFrame: CGRect = {self.sourceImageView.convertRect(self.sourceImageView.bounds, toView: nil)}()
        
        /**  本地相册专业初始化方法  */
        init(localImg: UIImage!, titleStr: String!, descStr: String!, sourceImageView: UIImageView!){
            
            self.localImg = localImg
            self.titleStr = titleStr
            self.descStr = descStr
            self.sourceImageView = sourceImageView
        }
    }
}
