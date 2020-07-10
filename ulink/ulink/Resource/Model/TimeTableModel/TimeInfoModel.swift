//
//  TimeInfo.swift
//  ulink
//
//  Created by 양시연 on 2020/07/11.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

public struct TimeInfoModel {
    public var weekDay : TimeTableDay
    public var startTime : String
    public var endTime : String
    
    public init(weekDay: TimeTableDay, startTime: String, endTime: String){
        self.weekDay = weekDay
        self.startTime = startTime
        self.endTime = endTime
    }
    
    public init(){
        self.weekDay = TimeTableDay.monday
        self.startTime = ""
        self.endTime = ""
    }
    
}
