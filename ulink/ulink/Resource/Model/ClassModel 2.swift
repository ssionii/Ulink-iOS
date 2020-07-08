//
//  ClassModel.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation




class ClassModel : NSObject {

    var className : String?
//    var uid : String?
    var key : String?
    
    
    
    init(name : String, key : String)
    {
        self.className = name
        self.key = key
    }


    
}
