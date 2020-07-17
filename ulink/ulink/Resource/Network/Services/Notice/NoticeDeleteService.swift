//
//  NoticeDeleteService.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

struct NoticeDeleteService {
    
    
    static let shared = NoticeDeleteService()

    


    func deleteNotice(noticeIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        
        
        guard let userToken = UserDefaults.standard.string(forKey: "token") else {return}
        
        let header: HTTPHeaders = ["token" : userToken,
                                   "Content-Type": "application/json"]
        let noticeURL : String = APIConstants.subjectDetailNoticeURL + "/" + String(noticeIdx)
        let dataRequest = Alamofire.request(noticeURL, method  : .delete, encoding:
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
            
        case 200 ... 299: return isSubject(by: json)
        case 400 ... 499: return .pathErr
        case 500 ... 599: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
    private func isSubject(by json: JSON) -> NetworkResult<Any> {
        
        let data = json["data"] as JSON
        

        
            
                

        
        
        return .success(1,1)
    }
}

