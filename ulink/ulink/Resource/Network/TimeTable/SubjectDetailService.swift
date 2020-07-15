//
//  SubjectDetailService.swift
//  ulink
//
//  Created by 양시연 on 2020/07/15.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

struct SubjectDetailService {

    private init() {}
    static let shared = SubjectDetailService()
    private func makeParameter(_ isSubject : Bool) -> Parameters {
        return ["isSubject": isSubject]
       }
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
//        "token" : UserDefaults.standard.object(forKey: "token") as! String
      "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJuYW1lIjoi6rmA67O067CwIiwic2Nob29sIjoi7ZWc7JaR64yA7ZWZ6rWQIiwibWFqb3IiOiLshoztlITtirjsm6jslrQiLCJpYXQiOjE1OTQ3NzkxODAsImV4cCI6MTU5NjIxOTE4MCwiaXNzIjoiYm9iYWUifQ.BAOeiZ_uqtIVPzFJd2oZbfVz44A2_QSXLQliNhN6pv4"
    ]
    
    func getMainTimeTable(idx: Int, isSubject: Bool, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        Alamofire.request(APIConstants.specificTimeTable + "/\(idx)?isSubject=\(isSubject)", method  : .get, encoding: JSONEncoding.default, headers: header).responseJSON {
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
            
        case 200: return setData(by: json)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
   private func setData(by json: JSON) -> NetworkResult<Any> {
        
        let data = json["data"] as JSON

        let subjectDetail = SubjectModel.init(subjectIdx: data["subjectIdx"].intValue, name: data["name"].stringValue, color: data["color"].intValue,
                                              day : data["day"].arrayObject as! [Int],
            startTime: data["startTime"].arrayObject as! [String], endTime: data["endTime"].arrayObject as! [String], content: data["content"].arrayObject as! [String], professor: data["professor"].stringValue)

        return .success(subjectDetail, 0)
    }
}
