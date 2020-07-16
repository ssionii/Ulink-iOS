//
//  ChattingListData.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation




//                "subjectIdx": 4,
////                "name": "경영학개론",
////                "color": 1,
////                "total": 15,
////                "current": 2



public struct ChattingListData{
    
    
    public let subjectIdx : Int
    public let name : String
    public let color : Int
    public let total : Int
    public let current : Int

    
    
    public init(idx : Int, name : String, color : Int, total : Int, current : Int)
    {
        
        self.subjectIdx = idx
        self.name = name
        self.color = color
        self.total = total
        self.current = current
    }
    
    
}
