//
//  SubjectNoticeData.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation


public struct SubjectNoticeData{
    
    
    public let noticeIdx : Int
    public let title : String
    public let startTime : String
    public let endTime : String
    public let date : String
    public let content : String
    
    
    public init(idx : Int, Title : String, start : String, end : String, dateTime : String)
    {
        
        self.noticeIdx = idx
        self.title = Title
        self.startTime = start
        self.endTime = end
        self.date = dateTime
        self.content = ""
    }
    
    
    public init(idx : Int, Title : String, start : String, end : String, dateTime : String, contents : String)
    {
        
        self.noticeIdx = idx
        self.title = Title
        self.startTime = start
        self.endTime = end
        self.date = dateTime
        self.content = contents
    }
}



//// MARK: - DataClass
//
//struct SubjectNoticeData: Codable {
//    let status: Int
//    let success: Bool
//    let message: String
//    let data: NoticeCategoryModel
//
//
//        enum CodingKeys: String, CodingKey{
//            case status = "status"
//            case success = "success"
//            case message = "message"
//            case data = "data"
//        }
//
//
//
//
//
//
//
//
//}
//
//// MARK: - DataClass
//struct NoticeCategoryModel: Codable {
//    let 과제, 시험, 수업: [NoticeModel]
//}
//
//// MARK: - 과제
//struct NoticeModel: Codable {
//    let noticeIdx: Int
//    let title, startTime, endTime, date: String
//
//    init(Idx : Int, Title: String, Start:String, End : String, Date: String)
//    {
//
//        self.title = Title
//        self.startTime = Start
//        self.endTime = End
//        self.date = Date
//
//        self.noticeIdx = Idx
//
//    }
//}
//


//import Foundation
//
//
//
//struct SigninData: Codable {
//
//    let status: Int
//    let success: Bool
//    let message: String
//    var data: TokenData?
//
//
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
//        data = (try? values.decode(TokenData.self, forKey: .data)) ?? nil
//    }
//}
//
//
//
//struct TokenData: Codable{
//    let uid, accessToken: String
//}
