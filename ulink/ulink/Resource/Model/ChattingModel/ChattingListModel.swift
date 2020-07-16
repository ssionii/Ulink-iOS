//
//  ChattingListModel.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/15.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

// MARK: - Empty
struct ChattingListModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let semester: String
    let chat: [Chat]
}

// MARK: - Chat
struct Chat: Codable {
    let subjectIdx: Int
    let name: String
    let color, total, current: Int
}
