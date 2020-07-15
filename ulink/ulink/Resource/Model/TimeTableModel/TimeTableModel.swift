//
//  TimeTable.swift
//  ulink
//
//  Created by 양시연 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

public struct TimeTableModel {
    public let scheduleIdx : Int
    public let name : String
    public let semester : String
    public let isMain : Int
    public var subjectList : [SubjectModel]
    
    // 통신에서 값 받아올 때 이용
    public init(scheduleIdx: Int, semester: String, name: String){
        
        self.scheduleIdx = scheduleIdx
        self.name = name
        
        var year : String = String(semester.split(separator: "-")[0])
        switch semester.split(separator : "-")[1] {
        case "0":
            year.append(" 1학기")
        case "1":
            year.append(" 여름학기")
        case "2":
            year.append(" 2학기")
        case "3":
            year.append(" 겨울학기")
        default:
            year.append(" 1학기")
        }
        self.semester = year
        
        self.isMain = 0
        self.subjectList = []
    }
    
    
    // list에서 이용
    public init(scheduleIdx: Int, name: String, semesterInput: String, isMain: Int){
        self.scheduleIdx = scheduleIdx
        self.name = name
        self.isMain = isMain
        
        var year : String = String(semesterInput.split(separator: "-")[0])
        switch semesterInput.split(separator : "-")[1] {
        case "0":
            year.append(" 1학기")
        case "1":
            year.append(" 여름학기")
        case "2":
            year.append(" 2학기")
        case "3":
            year.append(" 겨울학기")
        default:
            year.append(" 1학기")
        }
        self.semester = year
        
        self.subjectList = []
           
    }
    
    public init(idx: Int, name: String, subjectList: [SubjectModel]){
        self.scheduleIdx = idx
        self.name = name
        self.subjectList = subjectList
        
        self.semester = ""
        self.isMain = 0
    }
}
