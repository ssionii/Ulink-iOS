//
//  File.swift
//  ulink
//
//  Created by 양시연 on 2020/07/17.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

public struct TimeTableContainerModel {
    public let timeTable : TimeTableModel
    public let subjects : [SubjectModel]
    
    public init(timeTable : TimeTableModel, subjects : [SubjectModel]){
        self.timeTable = timeTable
        self.subjects = subjects
    }
}
