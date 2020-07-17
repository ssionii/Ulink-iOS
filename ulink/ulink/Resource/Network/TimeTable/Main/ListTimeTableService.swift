
//
//  ListTimeTableServcie.swift
//  ulink
//
//  Created by 양시연 on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON


struct ListTimeTableService {
    
    private init() { }
    static let shared = ListTimeTableService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : UserDefaults.standard.object(forKey: "token") as! String
    ]
    
    func getListTimeTable(completion: @escaping (NetworkResult<Any>) -> Void) {
        Alamofire.request(APIConstants.listTimeTable, method  : .get, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.result.value else { return }
                let json = JSON(value)
                let networkResult = self.judge(type : "main", by: statusCode, json)
                completion(networkResult)
            case .failure:
                  print(2)
                completion(.networkFail)
            }
        }
    }
    
    func getListTimeTable(semester : String, completion: @escaping (NetworkResult<Any>) -> Void) {
    
        print(semester)
        
        Alamofire.request(APIConstants.listTimeTable + "?semester=\(semester)", method  : .get, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                print(1)
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.result.value else { return }
                let json = JSON(value)
                let networkResult = self.judge(type : "create", by: statusCode, json)
                completion(networkResult)
            case .failure:
                print(2)
                completion(.networkFail)
            }
        }
    }
    
    private func judge(type : String, by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
        
        print(type)
        print(statusCode)
        switch statusCode {
        
        case 200:
            if type == "create" {
                return setDataList(by: json)
            }else {
                return setData(by: json)
            }
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    

    
   private func setData(by json: JSON) -> NetworkResult<Any> {
        
    let data = json["data"].arrayValue
    
    var listSemesterList = [ListSemester]()
    for (_, d) in data.enumerated() {
        
        let timeTableList = d["timeTableList"].arrayValue
        var tempTimeTableList = [TimeTableModel]()
        
        for (_, ttl) in timeTableList.enumerated(){
            let timeTable = TimeTableModel.init(scheduleIdx: ttl["scheduleIdx"].intValue, name: ttl["name"].stringValue, semesterInput: d["semester"].stringValue, isMain: ttl["isMain"].intValue)
        
            tempTimeTableList.append(timeTable)
        }
        
        let listSemester = ListSemester.init(semester: d["semester"].stringValue , timeTableList: tempTimeTableList)
        listSemesterList.append(listSemester)
    }
    
        return .success(listSemesterList, 0)
    }
    
    private func setDataList(by json: JSON) -> NetworkResult<Any> {
        
        let dataList = json["data"].arrayValue
        
        var container = [TimeTableContainerModel]()
        for data in dataList {
            
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
            let containerModel = TimeTableContainerModel.init(timeTable: timeTableModel, subjects: subjectList)
            container.append(containerModel)
        }

    return .success(container, 0)
    }
}
