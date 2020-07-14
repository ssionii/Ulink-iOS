//
//  LoginSuccessData.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation




public struct LoginSuccessData{

    public var token : String?
    public var uid : String?
    
    init()
    {
        self.token = ""
        self.uid = ""
    }
    
}
