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
    public var timeTableList : [TimeTableModel] = []
    
    public init(nameInput: String, timeTableList: [TimeTableModel]){
        
        var name : String = String(nameInput.split(separator: "-")[0])
        switch nameInput.split(separator : "-")[1] {
        case "0":
            name.append("년 1학기")
        case "1":
            name.append("년 여름학기")
        case "2":
            name.append("년 2학기")
        case "3":
            name.append("년 겨울학기")
        default:
            name.append("년 1학기")
        }
        self.semester = name
        
        self.timeTableList = timeTableList
    }
    
    

}
