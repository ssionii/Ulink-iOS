//
//  TimeTableService.swift
//  ulink
//
//  Created by 양시연 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON


struct MainTimeTableService {
    
    private init() { }
    static let shared = MainTimeTableService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
//        "token" : UserDefaults.standard.object(forKey: "token") as! String
        "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJuYW1lIjoi6rmA67O067CwIiwic2Nob29sIjoi7ZWc7JaR64yA7ZWZ6rWQIiwibWFqb3IiOiLsnLXtlansoITsnpDqs7XtlZnrtoAiLCJpYXQiOjE1OTQ4MzkzOTEsImV4cCI6MTU5ODQzNTc5MSwiaXNzIjoiYm9iYWUifQ.jxont3bUINSAtQt_F90KeE376WX-cZJoB5rzM2K7Ccg"
    ]
    
    func getMainTimeTable(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        print("token! \(UserDefaults.standard.object(forKey: "token") as! String)")
        
        Alamofire.request(APIConstants.mainTimeTable, method  : .get, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.result.value else { return }
                let json = JSON(value)
                let networkResult = self.judge(type: 0, by: statusCode, json)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func updateMainTimeTable(idx:Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        print("hello")
        
        Alamofire.request(APIConstants.mainTimeTable + "/\(idx)", method : .put, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            print(response.result)
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.result.value else { return }
                let json = JSON(value)
                let networkResult = self.judge(type : 2, by: statusCode, json)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    private func judge(type: Int, by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
        switch statusCode {
            
        case 200:
            if type == 0 {
                return setData(by: json)
            }else {
                return .success(0, 0)
            }
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    

    
   private func setData(by json: JSON) -> NetworkResult<Any> {
        
        let data = json["data"] as JSON
        let timeTable = data["timeTable"]
        let timeTableModel = TimeTableModel.init(scheduleIdx: timeTable["scheduleIdx"].intValue, semester: timeTable["semester"].stringValue, name: timeTable["name"].stringValue)
            
        let subjects = data["subjects"]
        var subjectList = [SubjectModel]()
        for i in 0 ... 5 {
            let daySubjects = subjects[String(i)].arrayValue
            for (_, subject) in daySubjects.enumerated() {
                let element = SubjectModel.init(idx: subject["idx"].intValue, name: subject["name"].stringValue, startTime: subject["startTime"].arrayObject as! [String], endTime: subject["endTime"].arrayObject as! [String], day: subject["day"].arrayObject as! [Int], content: subject["content"].arrayObject as! [String], color: subject["color"].intValue, subject: subject["subject"].boolValue)
                    
                subjectList.append(element)
            }
        }

        return .success(timeTableModel, subjectList)
    }
}
