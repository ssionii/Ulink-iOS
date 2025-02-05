//
//  SemesterList.swift
//  ulink
//
//  Created by 양시연 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

public struct ListSemester {
    public let semester : String
    public let semesterName : String
    public var timeTableList : [TimeTableModel] = []
    
    public init(nameInput: String?, semester : String, timeTableList: [TimeTableModel]){
        
        if(nameInput != nil){
            var name : String = String(nameInput!.split(separator: "-")[0])
            switch nameInput!.split(separator : "-")[1] {
            case "1":
                name.append("년 1학기")
            case "2":
                name.append("년 여름학기")
            case "3":
                name.append("년 2학기")
            case "4":
                name.append("년 겨울학기")
            default:
                name.append("년 1학기")
            }
            self.semesterName = name
        }else{
            self.semesterName = ""
        }
        
        self.semester = semester
        self.timeTableList = timeTableList
    }
    
    public init(semester : String, timeTableList: [TimeTableModel]){
        self.semester = semester
        self.timeTableList = timeTableList
        
        self.semesterName = ""
    }
    
    

}
