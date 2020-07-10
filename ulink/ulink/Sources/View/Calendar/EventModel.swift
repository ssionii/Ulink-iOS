//
//  eventModel.swift
//  ulink
//
//  Created by SeongEun on 2020/07/09.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

public struct Event{
    var name: String
    var color: Int
    var notice_idx: Int
    var category: String
    var start_time: String
    var end_time: String
    var title: String
    
    init(name: String, color: Int, notice_idx: Int, category: String, start_time: String, end_time: String, title: String){
        self.name = name
        self.color = color
        self.notice_idx = notice_idx
        self.category = category
        self.start_time = start_time
        self.end_time = end_time
        self.title = title
    }
}

public struct EventList{
    var date: String
    var event: [Event]
    
    init(date: String, event: [Event]){
        self.date = date
        self.event = event
    }
}


