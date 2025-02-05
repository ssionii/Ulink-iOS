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


struct NoticeEditService {
    
    
    static let shared = NoticeEditService()
    
//
//    {
//      "category": "수업",
//      "date": "2020-12-17",
//      "startTime": "-1",
//      "endTime": "-1",
//      "title": "폐강",
//      "content": "수업없어짐"
//    }
    
    
    private func makeParameter(_ category: String, _ date: String, _ startTime: String,_ endTime: String,_ title: String,_ content: String) -> Parameters {
        return ["category": category,
                "date": date,
                "startTime":startTime ,
                "endTime":endTime,
                "title" :title,
                "content": content]
    }


    func uploadNotice(category: String, date : String, startTime: String, endTime : String, title : String, content: String,subjectIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        
        
        guard let userToken = UserDefaults.standard.string(forKey: "token") else {return}
        
        let header: HTTPHeaders = ["token" : userToken,
                                   "Content-Type": "application/json"]
        let noticeURL : String = APIConstants.subjectNoticeURL + "/" + String(subjectIdx)
        let dataRequest = Alamofire.request(noticeURL, method  : .post,parameters: makeParameter(category, date,startTime,endTime,title,content), encoding:
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
        default:
            do {
                print("현재 networkFail로 떨어졌습니다 statusCODE : \(statusCode)")
                return .networkFail
            }
        }
    }
    
    
    
        private func isSubject(by data: Data) -> NetworkResult<Any> {


         
            return .success(1,1)
        }
    }


