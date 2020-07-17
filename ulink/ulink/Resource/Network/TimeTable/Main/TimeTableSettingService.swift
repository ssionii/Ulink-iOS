//
//  TimeTableSettingService.swift
//  ulink
//
//  Created by 양시연 on 2020/07/17.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON


struct TimeTableSettingService {
    
    private init() { }
    static let shared = TimeTableSettingService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : UserDefaults.standard.object(forKey: "token") as! String
    ]
    
    func editTimeTableName(idx: Int, name: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        
        Alamofire.request(APIConstants.name + "/\(idx)", method : .put, parameters : ["name" : name], encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.result.value else { return }
                let json = JSON(value)
                let networkResult = self.judge(by: statusCode, json)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }

    private func judge(by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
        switch statusCode {
            
        case 200:
            return .success(0, 0)
        case 201:
            return .success(0, 0)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

}

