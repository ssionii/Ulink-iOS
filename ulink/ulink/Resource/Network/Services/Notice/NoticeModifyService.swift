//
//  NoticeEditService.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/15.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct NoticeModifyService {
    
    
    static let shared = NoticeModifyService()
    
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
    
    private func makeParameter(_ category: String, _ date: String, _ startTime: String,_ endTime: String,_ title: String,_ content: String) -> Parameters {
        return ["category": category,
                "date": date,
                "startTime":startTime ,
                "endTime":endTime,
                "title" :title,
                "content": content]
    }


    func uploadNotice(category: String, date : String, startTime: String, endTime : String, title : String, content: String,noticeIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        
        
        guard let userToken = UserDefaults.standard.string(forKey: "token") else {return}
        
        let header: HTTPHeaders = ["token" : userToken,
                                   "Content-Type": "application/json"]
        let noticeURL : String = APIConstants.subjectDetailNoticeURL + "/" + String(noticeIdx)
        let dataRequest = Alamofire.request(noticeURL, method  : .put,parameters: makeParameter(category, date,startTime,endTime,title,content), encoding:
            JSONEncoding.default, headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                
                
            
                
                let networkResult = self.judge(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.networkFail)
            }
        }
    }
    
    
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
            
        case 200 ... 299: return isSubject(by: data)
        case 400 ... 499: return .pathErr
        case 500 ... 599: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
        private func isSubject(by data: Data) -> NetworkResult<Any> {


         
            return .success(1,1)
        }
    }


