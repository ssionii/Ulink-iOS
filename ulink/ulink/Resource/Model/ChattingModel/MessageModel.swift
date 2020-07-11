//
//  MessageModel.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation



class ChattingModel : NSObject {
    
    
    var message : String
    var uid : String
    
    
    init(Message : String, Uid : String)
    {
        self.message = Message
        self.uid = Uid
    }


    
}
