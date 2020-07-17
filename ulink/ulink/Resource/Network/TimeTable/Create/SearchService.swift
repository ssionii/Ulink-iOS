//
//  File.swift
//  ulink
//
//  Created by 양시연 on 2020/07/17.
//  Copyright © 2020 송지훈. All rights reserved.
//


import Alamofire
import Foundation
import SwiftyJSON

struct SearchService{
    
    private init() { }
    static let shared = SearchService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : UserDefaults.standard.object(forKey: "token") as! String
    ]
    
    func searchSubject(name: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        var query: String = ""
        let queryWord = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                   
        query = "?name=\(queryWord)"
        
        print("query", APIConstants.searchURL + query)
        Alamofire.request(APIConstants.search + query, method : .get, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.result.value else { return }
                let json = JSON(value)
                let networkResult = self.judge(by: statusCode, json)
                completion(networkResult)
            case .failure:
                print(response.result.error)
                completion(.networkFail)
            }
        }
    }
    
    private func judge(by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
        
        print(statusCode)
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
    
            let subject = SubjectModel.init(subjectIdx: data["subjectIdx"].intValue, subjectCode: data["subjectCode"].stringValue, name: data["name"].stringValue, professor: data["professor"].stringValue, credit: data["credit"].intValue, course: data["course"].stringValue, startTime: data["startTime"].arrayObject as! [String], endTime: data["endTime"].arrayObject as! [String], day: data["day"].arrayObject as! [Int], content: data["content"].arrayObject as! [String])
            
            subjectList.append(subject)
        }

        return .success(subjectList, 0)
    }
}

