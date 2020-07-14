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


struct TimeTableService {
    
    private init() { }
    static let shared = TimeTableService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : UserDefaults.standard.object(forKey: "token") as! String
    ]
    
    func getMainTimeTable(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        print("token! \(UserDefaults.standard.object(forKey: "token") as! String)")
//        let url = APIConstants.mainTimeTable
        
        Alamofire.request(APIConstants.mainTimeTable, method  : .get, encoding: JSONEncoding.default, headers: header).responseJSON {
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
        let timeTable = data["timeTable"]
        let timeTableModel = TimeTableModel.init(scheduleIdx: timeTable["scheduleIdx"].intValue, semester: timeTable["semester"].stringValue, name: timeTable["name"].stringValue)
            
        let subjects = data["subjects"]
        var subjectList = [SubjectModel]()
        for i in 0 ... 5 {
            let daySubjects = subjects[String(i)].arrayValue
            for (_, subject) in daySubjects.enumerated() {
                let element = SubjectModel.init(idx: subject["idx"].intValue, name: subject["name"].stringValue, startTime: subject["startTime"].stringValue, endTime: subject["endTime"].stringValue, day: subject["day"].intValue, content: subject["content"].stringValue, color: subject["color"].intValue, subject: subject["subject"].boolValue)
                    
                subjectList.append(element)
            }
        }

        return .success(timeTableModel, subjectList)
    }
}
