//
//  NoticeModel.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

struct noticeInformation{
    

    var title : String
    var startTime : String
    var endTime : String
    var date : String
    var noticeIdx : Int
    
    
    init(title: String, start:String, end : String, Date : String, idx : Int)
    {
        
        self.title = title
        self.startTime = start
        self.endTime = end
        self.date = Date
        self.noticeIdx = idx

    }
}
