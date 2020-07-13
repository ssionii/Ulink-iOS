//
//  MessageModel.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation



class MessageModel : NSObject {
    
    
    public var message : String?
    public var uid : String?
    public var time : Int?
    public var readCount : Int?

    
    
    init(Message : String, Uid : String, Time : Int, ReadCount : Int)
    {
        self.message = Message
        self.uid = Uid
        self.time = Time
        self.readCount = ReadCount
    }
    
    
    override init()
    {
        self.message = ""
        self.uid = ""
        self.time = -1
        self.readCount = -1
    }



    
}
