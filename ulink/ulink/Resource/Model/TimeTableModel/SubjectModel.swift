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
    public var subjectName : String
    public var roomName : String
    public var subjectDay : TimeTableDay
    public var startTime : String
    public var endTime : String
    public var textColor : UIColor?
    public var backgroundColor : Int
    public var professorName: String
    public var course : String
    public var credit : Int
    public var timeInfo : String

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
    
    public init(){
        self.subjectName = ""
        self.professorName = ""
        self.timeInfo = ""
        self.roomName = ""
        self.course = ""
        self.credit = 0
        self.subjectDay = TimeTableDay.monday
        self.startTime = ""
        self.endTime = ""
        self.textColor = UIColor.white
        self.backgroundColor = 0
    }
}

