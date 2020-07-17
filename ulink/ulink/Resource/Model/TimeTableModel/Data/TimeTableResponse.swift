////
////  TimeTableData.swift
////  ulink
////
////  Created by 양시연 on 2020/07/14.
////  Copyright © 2020 송지훈. All rights reserved.
////
//
//import Foundation
//
//struct TimeTableResponse: Codable {
//
//    let status: Int
//    let success: Bool
//    let message: String
//    var data: MainTimeTableData?
//
//    enum CodingKeys: String, CodingKey{
//        case status = "status"
//        case success = "success"
//        case message = "message"
//        case data = "data"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
//        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
//        message = (try? values.decode(String.self, forKey: .message)) ?? ""
//        data = (try? values.decode(MainTimeTableData.self, forKey: .data)) ?? nil
//    }
//}
//
//struct MainTimeTableData : Codable {
//    let timeTable : TimeTableData
//    let subjects : dayData?
//
//    private enum CodingKeys : String, CodingKey {
//        case timeTable
//        case subjects
//    }
//
//    init(timeTable: TimeTableData, subjects : dayData?){
//        self.timeTable = timeTable
//        self.subjects = subjects
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        timeTable = try values.decode(TimeTableData.self, forKey: .timeTable)
//        subjects = try values.decode(dayData.self, forKey: .subjects)
//    }
//}
//
//struct TimeTableData : Codable {
//    let scheduleIdx : Int
//    let semester : String
//    let name : String
//}
//
//struct dayData : Codable {
//    let day_0 : [SubjectData]
//    let day_1 : [SubjectData]
//    let day_2 : [SubjectData]
//    let day_3 : [SubjectData]
//    let day_4 : [SubjectData]
//
//
//    private enum CodingKeys : String, CodingKey {
//        case day_0
//        case day_1
//        case day_2
//        case day_3
//        case day_4
//
//    }
//
//    init(day_0: [SubjectData], day_1: [SubjectData],day_2: [SubjectData],day_3: [SubjectData],day_4: [SubjectData]){
//        self.day_0 = day_0
//        self.day_1 = day_1
//        self.day_2 = day_2
//        self.day_3 = day_3
//        self.day_4 = day_4
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        day_0 = try values.decode([SubjectData].self, forKey: .day_0)
//        day_1 = try values.decode([SubjectData].self, forKey: .day_1)
//        day_2 = try values.decode([SubjectData].self, forKey: .day_2)
//        day_3 = try values.decode([SubjectData].self, forKey: .day_3)
//        day_4 = try values.decode([SubjectData].self, forKey: .day_4)
//    }
//}
//
//struct SubjectData : Encoder {
//
//    let idx : Int
//    let name : String
//    let startTime : String
//    let endTime : String
//    let day : Int
//    let content : String
//    let color : Int
//    let subject : Bool
//
//    private enum CodingKeys : String, CodingKey {
//           case idx
//           case day_1
//           case day_2
//           case day_3
//           case day_4
//
//       }
//
//       init(day_0: [SubjectData], day_1: [SubjectData],day_2: [SubjectData],day_3: [SubjectData],day_4: [SubjectData]){
//           self.day_0 = day_0
//           self.day_1 = day_1
//           self.day_2 = day_2
//           self.day_3 = day_3
//           self.day_4 = day_4
//
//       }
//
//       init(from decoder: Decoder) throws {
//           let values = try decoder.container(keyedBy: CodingKeys.self)
//           day_0 = try values.decode([SubjectData].self, forKey: .day_0)
//           day_1 = try values.decode([SubjectData].self, forKey: .day_1)
//           day_2 = try values.decode([SubjectData].self, forKey: .day_2)
//           day_3 = try values.decode([SubjectData].self, forKey: .day_3)
//           day_4 = try values.decode([SubjectData].self, forKey: .day_4)
//       }
//
//}
