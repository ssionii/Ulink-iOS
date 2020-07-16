//
//  LoadChattingListService.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/15.
//  Copyright © 2020 송지훈. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON


struct LoadChattingListService{
    
    static let shared = LoadChattingListService()
    
    
    func getSubjectDetailNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
    
            guard let userToken = UserDefaults.standard.string(forKey: "token") else {return}

                let header: HTTPHeaders = ["token" : userToken,
                                           "Content-Type": "application/json"]
                let chatURL : String = APIConstants.chatURL
                let dataRequest = Alamofire.request(chatURL, method  : .get, encoding:
                    JSONEncoding.default, headers: header)
        
              dataRequest.responseData { dataResponse in
                    switch dataResponse.result {
                    case .success:
        
                        guard let statusCode = dataResponse.response?.statusCode else { return }
                        guard let value = dataResponse.result.value else { return }
        
                        let json = JSON(value)
        
                        let networkResult = self.judge(by: statusCode, json)
                        completion(networkResult)
                    case .failure: completion(.networkFail)
                    }
                }
            }
        
        
            private func judge(by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
                switch statusCode {
        
                case 200: return isSubject(by: json)
                case 400: return .pathErr
                case 500: return .serverErr
                default: return .networkFail
                }
            }
        
        
        
    private func isSubject(by json: JSON) -> NetworkResult<Any> {
        
        let data = json["data"] as JSON
        print("cc")
        print(data)
        
        let chat = data["chat"] as JSON
        
        print(chat)
        

        
        var noticeList : [ChattingListData] = []
        
        
        
        
        for i in 0 ... chat.arrayValue.count - 1
        {
            
            let noticeModel = ChattingListData(
                idx: chat[i]["subjectIdx"].intValue,
                name: chat[i]["name"].stringValue,
                color: chat[i]["color"].intValue,
                total: chat[i]["total"].intValue,
                current: chat[i]["current"].intValue
            )
            
            
            print("NETWORK...")
            print(noticeModel)
            
            
            noticeList.append(noticeModel)
            
   
            
            
            
        }
        print(noticeList)
        

        
        
        
        
        
        
        
        return .success(noticeList,chat.arrayValue.count) // 채팅 목록 리스트랑 갯수를 success 인자로 넘길거임
        
        
    }
    
    
    
        
        
}



//
//
//
//{
//    "status": 200,
//    "success": true,
//    "message": "채팅 목록 조회 성공",
//    "data": {
//        "semester": "2020-1",
//        "chat": [
//            {
//                "subjectIdx": 3,
//                "name": "컴퓨터 네트워크",
//                "color": 6,
//                "total": 20,
//                "current": 1
//            },
//            {
//                "subjectIdx": 4,
//                "name": "경영학개론",
//                "color": 1,
//                "total": 15,
//                "current": 2
//            },
//            {
//                "subjectIdx": 99,
//                "name": "에너지나노과학",
//                "color": 9,
//                "total": 40,
//                "current": 1
//            }
//        ]
//    }
//}
