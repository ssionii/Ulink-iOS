//
//  Subject.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import UIKit

public struct SubjectModel {
    public let subjectName : String
    public let roomName : String
    public let subjectDay : TimeTableDay
    public let startTime : String
    public let endTime : String
    public let textColor : UIColor?
    public let backgroundColor : Int
    public let professorName: String
    public let course : String
    public let credit : Int
    public let timeInfo : String

    public init(subjectName: String, roomName: String, subjectDay: TimeTableDay, startTime: String, endTime: String, textColor: UIColor?, backgroundColor: Int){
        self.subjectName = subjectName
        self.roomName = roomName
        self.subjectDay = subjectDay
        self.startTime = startTime
        self.endTime = endTime
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        
        self.professorName = ""
        self.course = ""
        self.credit = 0
        self.timeInfo = ""
        
    }

    public init(subjectName: String, roomName: String, subjectDay: TimeTableDay, startTime: String, endTime: String, backgroundColor: Int){
        self.subjectName = subjectName
        self.roomName = roomName
        self.subjectDay = subjectDay
        self.startTime = startTime
        self.endTime = endTime
        self.textColor = UIColor.white
        self.backgroundColor = backgroundColor
        
        self.professorName = ""
        self.course = ""
        self.credit = 0
        self.timeInfo = ""
    }
    
    public init(subjectName: String, professorName: String, timeInfo: String, roomName: String, course: String, credit: Int){
        self.subjectName = subjectName
        self.professorName = professorName
        self.timeInfo = timeInfo
        self.roomName = roomName
        self.course = course
        self.credit = credit
        
        self.subjectDay = TimeTableDay.friday
        self.startTime = ""
        self.endTime = ""
        self.textColor = UIColor.white
        self.backgroundColor = 0
        
    }
}

