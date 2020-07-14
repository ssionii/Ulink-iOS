//
//  SignInData.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/13.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

struct CalendarData: Codable {
    
    let status: Int
    let success: Bool
    let message: String
    var data: SecondData?
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(SecondData.self, forKey: .data)) ?? nil
    }
}

struct SecondData: Codable {
    var date: String
    var notice: NoticeData?
    
    enum CodingKeys: String, CodingKey{
        case date = "date"
        case notice = "notice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = (try? values.decode(String.self, forKey: .date)) ?? ""
        notice = (try? values.decode(NoticeData.self, forKey: .notice)) ?? nil
    }
}

struct NoticeData: Codable {
    var name: String
    var color: Int
    var noticeIdx: Int
    var category: String
    var startTime: String
    var endTime: String
    var title: String
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case color = "color"
        case noticeIdx = "noticeIdx"
        case category = "category"
        case startTime = "startTime"
        case endTime = "endTime"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        color = (try? values.decode(Int.self, forKey: .color)) ?? -1
        noticeIdx = (try? values.decode(Int.self, forKey: .noticeIdx)) ?? -1
        category = (try? values.decode(String.self, forKey: .category)) ?? ""
        startTime = (try? values.decode(String.self, forKey: .startTime)) ?? ""
        endTime = (try? values.decode(String.self, forKey: .endTime)) ?? ""
        title = (try? values.decode(String.self, forKey: .title)) ?? ""
    }
}
//
//struct TokenData: Codable{
//    let uid, accessToken: String
//}
