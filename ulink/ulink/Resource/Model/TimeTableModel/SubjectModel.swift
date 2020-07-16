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
    public var subjectIdx : Int
    public var subjectName : String
    public var content : [String]
    public var subjectDay : [Int]
    public var startTime : [String]
    public var endTime : [String]
    public var textColor : UIColor?
    public var backgroundColor : Int
    public var professorName: String
    public var course : String
    public var credit : Int
    public var subjectNum : String
    public var isSubject : Bool
    
    
    // main에서 쓰는 init
    public init(idx: Int, name: String, startTime: [String], endTime: [String], day: [Int], content: [String], color: Int, subject: Bool) {
        self.subjectIdx = idx
        self.subjectName = name
        self.startTime = startTime
        self.endTime = endTime
        self.subjectDay = day
        self.content = content
        self.backgroundColor = color
        self.isSubject = subject
        self.textColor = UIColor.white
        
        self.professorName = ""
        self.course = ""
        self.credit = 0
        self.subjectNum = ""
    
    }
    
    // subject detail에서 쓰는 init
    public init(subjectIdx: Int, name: String, color: Int, day : [Int], startTime: [String], endTime: [String], content : [String], professor : String){
        self.subjectIdx = subjectIdx
        self.subjectName = name
        self.backgroundColor = color
        self.subjectDay = day
        self.startTime = startTime
        self.endTime = endTime
        self.content = content
        self.professorName = professor
                
        self.credit = 0
        self.subjectNum = ""
        self.isSubject = false
        self.course = ""
    }
      
    // 과목 검색 등에서 쓰는 init
    public init(subjectIdx: Int, subjectCode: String, name: String, professor: String, credit: Int, course: String, startTime :[String], endTime : [String], day : [Int], content : [String]){
        self.subjectIdx = subjectIdx
        self.subjectNum = subjectCode
        self.subjectName = name
        self.professorName = professor
        self.credit = credit
        self.course = course
        self.startTime = startTime
        self.endTime = endTime
        self.subjectDay = day
        self.content = content
        
        self.isSubject = false
        self.backgroundColor = 1
        
    }

    
    public init(subjectName: String, content: [String], subjectDay: [Int], startTime: [String], endTime: [String], textColor: UIColor?, backgroundColor: Int){
        self.subjectName = subjectName
        self.content = content
        self.subjectDay = subjectDay
        self.startTime = startTime
        self.endTime = endTime
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        
        self.subjectIdx = 0
        self.isSubject = false
        self.professorName = ""
        self.course = ""
        self.credit = 0
        self.subjectNum = ""
        
    }

//    public init(subjectName: String, content: [String], subjectDay: Int, startTime: [String], endTime: [String], backgroundColor: Int){
//        self.subjectName = subjectName
//        self.content = content
//        self.subjectDay = TimeTableDay.init(rawValue: subjectDay)!
//        self.startTime = startTime
//        self.endTime = endTime
//        self.textColor = UIColor.white
//        self.backgroundColor = backgroundColor
//
//        self.subjectIdx = 0
//        self.isSubject = false
//        self.professorName = ""
//        self.course = ""
//        self.credit = 0
//        self.isExpand = false
//        self.subjectNum = ""
//        self.day = []
//    }
    
    /*
    public init(subjectName: String, professorName: String, content: [String], course: String, credit: Int, subjectNum: String, day: [Int], dateTime: [String]){
        self.subjectName = subjectName
        self.professorName = professorName
        self.content = content
        self.course = course
        self.credit = credit
        self.subjectNum = subjectNum
        self.day = day
        self.subjectIdx = 0
        self.isSubject = false
        
        self.subjectDay = TimeTableDay.friday
        self.startTime = []
        self.endTime = []
        self.textColor = UIColor.white
        self.backgroundColor = 0
        self.isExpand = false
    }
    
    public init(subjectName: String, content: [String], professorName: String, backgroundColor: Int, day: [Int], dateTime : [String]){
            self.subjectName = subjectName
            self.content = content
            self.professorName = professorName
            self.backgroundColor = backgroundColor
            self.day = day
           
            self.subjectIdx = 0
            self.isSubject = false
            self.subjectDay = TimeTableDay.monday
            self.startTime = []
            self.endTime = []
            self.textColor = UIColor.white
           
            self.course = ""
            self.credit = 0
            self.isExpand = false
            self.subjectNum = ""
           
    }
    
//
//    public init(subjectName: String, roomName: String, professorName: String, subjectDay: Int, startTime : String, endTime:String, backgroundColor: Int, day: [Int], dateTime : [String]){
//        self.subjectName = subjectName
//        self.roomName = roomName
//        self.professorName = professorName
//        self.backgroundColor = backgroundColor
//        self.day = day
//        self.dateTime = dateTime
//        self.subjectDay = TimeTableDay.init(rawValue: subjectDay)!
//        self.startTime = startTime
//        self.endTime = endTime
//
//        self.textColor = UIColor.white
//
//         self.course = ""
//         self.credit = 0
//         self.isExpand = false
//         self.subjectNum = ""
//        self.subjectIdx = 0
//        self.isSubject = false
//        self.content = ""
//
//    }
//
 */
 
    public init(){
        self.subjectName = ""
        self.professorName = ""
        self.content = []
        self.course = ""
        self.credit = 0
        self.subjectDay = []
        self.startTime = []
        self.endTime = []
        self.textColor = UIColor.white
        self.backgroundColor = 0
        self.subjectNum = ""
        self.subjectIdx = 0
        self.isSubject = false
    }
}

