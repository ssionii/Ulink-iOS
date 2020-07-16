//
//  CartService.swift
//  ulink
//
//  Created by 양시연 on 2020/07/17.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import Alamofire
import Foundation
import SwiftyJSON


struct CartService {
    
    private init() { }
    static let shared = CartService()
    private func makeParameter(_ semester : String, _ subjectIdx: Int) -> Parameters {
           return [
            "semester": semester,
            "subjectIdx" : subjectIdx
        ]
    }
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : UserDefaults.standard.object(forKey: "token") as! String
    ]
    
    func postCart(semester: String, subjectIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        Alamofire.request(APIConstants.cart, method : .post, parameters : makeParameter(semester, subjectIdx), encoding: JSONEncoding.default, headers: header).responseJSON {
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
    
    func getCart(semester : String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        Alamofire.request(APIConstants.cart + "?semester=\(semester)", method : .get,  encoding: JSONEncoding.default, headers: header).responseJSON {
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
        case 201 : return .success(0, 0)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    

    
   private func setData(by json: JSON) -> NetworkResult<Any> {
    
    let dataList = json["data"].arrayValue
    
    var subjectList = [SubjectModel]()
    
      for data in dataList {
        
        let element = SubjectModel.init(subjectIdx: data["subjectIdx"].intValue, subjectCode: data["subjectCode"].stringValue, name: data["name"].stringValue, professor: data["professor"].stringValue, credit: data["credit"].intValue, course: data["course"].stringValue, startTime: data["startTime"].arrayObject as! [String], endTime: data["endTime"].arrayObject as! [String], day: data["day"].arrayObject as! [Int], content: data["content"].arrayObject as! [String])
            
        subjectList.append(element)
    }

         return .success(subjectList, 0)
    }
}

