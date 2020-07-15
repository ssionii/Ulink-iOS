
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
//        "token" : UserDefaults.standard.object(forKey: "token") as! String
        "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJuYW1lIjoi6rmA67O067CwIiwic2Nob29sIjoi7ZWc7JaR64yA7ZWZ6rWQIiwibWFqb3IiOiLshoztlITtirjsm6jslrQiLCJpYXQiOjE1OTQ3NzkxODAsImV4cCI6MTU5NjIxOTE4MCwiaXNzIjoiYm9iYWUifQ.BAOeiZ_uqtIVPzFJd2oZbfVz44A2_QSXLQliNhN6pv4"
    ]
    
    func getListTimeTable(completion: @escaping (NetworkResult<Any>) -> Void) {
    
        Alamofire.request(APIConstants.listTimeTable, method  : .get, encoding: JSONEncoding.default, headers: header).responseJSON {
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
        
    let data = json["data"].arrayValue
    
    var listSemesterList = [ListSemester]()
    for (index, d) in data.enumerated() {
        
        
        let timeTableList = d["timeTableList"].arrayObject as! [TimeTableModel]
        var tempTimeTableList = [TimeTableModel]()
        
        for (index2, ttl) in timeTableList.enumerated(){
            
            var timeTable = TimeTableModel.init(scheduleIdx: ttl.scheduleIdx, name: ttl.name, semesterInput: d["semester"].stringValue, isMain: ttl.isMain)
        
            tempTimeTableList.append(timeTable)
        }
        
        let listSemester = ListSemester.init(nameInput:  d["semester"].stringValue, timeTableList: tempTimeTableList)
        listSemesterList.append(listSemester)
    }
    
        return .success(listSemesterList, 0)
    }
}
