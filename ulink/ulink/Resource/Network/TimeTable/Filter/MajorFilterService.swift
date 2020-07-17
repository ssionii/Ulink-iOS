//
//  MajorFilterService.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/17.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct MajorFilterService{
    
    
    
    
    
    static let shared = MajorFilterService()
    
    
    func getMajorFilter(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        guard let userToken = UserDefaults.standard.string(forKey: "token") else {return}
        
        let header: HTTPHeaders = ["token" : userToken,
                                   "Content-Type": "application/json"]
        let chatURL : String = APIConstants.courseURL
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
            
        case 200 ... 299: return isSubject(by: json)
        case 400 ... 499: return .pathErr
        case 500 ... 599: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
    private func isSubject(by json: JSON) -> NetworkResult<Any> {
        
        let data = json["data"] as JSON
        
        var filterList : [String] = []
        
        
        if(data.count > 0)
        {
            for i in 0 ... data.count - 1
            {
                filterList.append(data[i].stringValue)
                
            }
        }
        
        
        

        

        
        
        return .success(filterList,data.count ) // 채팅 목록 리스트랑 갯수를 success 인자로 넘길거임
        
        
    }
    
    
    
    
    
}


