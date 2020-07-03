//
//  ChatModel.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import UIKit



class ChatModel: NSObject {

    public var users :Dictionary<String,Bool> = [:] // 채팅방에 참여한 사람들
    public var comments : Dictionary<String,Comment> = [:] // 채팅방의 대화내용
    
    
    public class Comment{
        public var uid : String?
        public var message : String?
    }
}
