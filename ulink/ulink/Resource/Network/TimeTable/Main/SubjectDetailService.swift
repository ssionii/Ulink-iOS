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
        "token" : UserDefaults.standard.object(forKey: "token") as! String
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
    
    func deleteSubject(idx: Int, isSubject: Bool, completion: @escaping (NetworkResult<Any>) -> Void) {
        
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
    
    func deleteSchoolSubject(idx : Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    
        Alamofire.request(APIConstants.schoolScheudle + "/\(idx)", method  : .delete, encoding: JSONEncoding.default, headers: header).responseJSON {
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
        case 204: return .success(0, 0)
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
