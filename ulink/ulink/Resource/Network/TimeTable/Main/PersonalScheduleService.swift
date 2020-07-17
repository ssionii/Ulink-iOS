//
//  PersonalScheduleService.swift
//  ulink
//
//  Created by 양시연 on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON


struct PersonalScheduleService {
    
    private init() { }
    static let shared = PersonalScheduleService()
    private func makeParameter(_ list : [PersonalScheduleModel]) -> Parameters {
        
         // struct를 json으로 바꾼다
           var resultList = [String]()
           let encoder = JSONEncoder()
           encoder.outputFormatting = .prettyPrinted
           var parameter: String = ""
           for(index, value) in list.enumerated(){
             let key = "schedule[\(index)]"
             var dicdic = value
             let jsonData = try? encoder.encode(dicdic)
             if let jsonString = String(data: jsonData!, encoding: .utf8) {
               parameter = String(jsonString.filter { !" \n\t\r".contains($0) })
             }
             resultList.append(parameter)
           }
           // var json: JSON = JSON([“schedule” : parameter])
           return ["scheduleList" : resultList]

    }
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : UserDefaults.standard.object(forKey: "token") as! String
    ]
    
    func postPersonalScheudule(personalScheudleList: [PersonalScheduleModel], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        print("hello1")
        
        Alamofire.request(APIConstants.personalSchedule, method : .post, parameters: makeParameter(personalScheudleList), encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.result.value else { return }
                let json = JSON(value)
                let networkResult = self.judge(by: statusCode, json)
                completion(networkResult)
            case .failure:
                 print("hello3")
                completion(.networkFail)
            }
        }
    }
    
    private func judge(by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
         print("status", statusCode)
        switch statusCode {
        case 200: return .success(0, 0)
        case 201: return .success(0, 0)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}

