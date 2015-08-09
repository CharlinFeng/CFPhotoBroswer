//
//  CFPhotoBroserVC+Common.swift
//  CFPhotoBroswerVC
//
//  Created by 成林 on 15/8/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit

let CFPBExtraWidth: CGFloat = 20

let CFPBSingleTapNofi = "CFPBSingleTapNofi"
let CFPBDismissBtnClickNoti = "CFPBDismissBtnClickNoti"

extension CGSize{
    
    var sizeWithExtraWidth: CGSize {return CGSizeMake(self.width + CFPBExtraWidth, self.height)}
    
}




