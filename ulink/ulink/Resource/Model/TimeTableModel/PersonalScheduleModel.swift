//
//  File.swift
//  ulink
//
//  Created by 양시연 on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

public struct PersonalScheduleModel : Codable {
    public var name : String
    public var startTime : String
    public var endTime : String
    public var day : Int
    public var content : String
    public var color : Int
    public var scheduleIdx : Int
    
    public init(name: String, startTime: String, endTime: String, day: Int, content: String, color: Int, scheudleIdx: Int){
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.day = day
        self.content = content
        self.color = color
        self.scheduleIdx = scheudleIdx
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case day = "day"
        case content = "content"
        case color = "color"
        case startTime = "startTime"
        case endTime = "endTime"
        case scheduleIdx = "scheduleIdx"
    }
    
}
