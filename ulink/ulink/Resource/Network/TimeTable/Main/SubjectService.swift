//
//  ScheudleServcie.swift
//  ulink
//
//  Created by 양시연 on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON


struct SubjectService{
    
    private init() { }
    static let shared = SubjectService()
    private func makeParameter(_ subjectIdx : Int, _ color : Int, _ scheduleIdx : Int ) -> Parameters {
        return  [
            "subjectIdx" : subjectIdx,
            "color" : color,
            "scheduleIdx" : scheduleIdx
        ]
    }
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
//        "token" : UserDefaults.standard.object(forKey: "token") as! String
        "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJuYW1lIjoi6rmA67O067CwIiwic2Nob29sIjoi7ZWc7JaR64yA7ZWZ6rWQIiwibWFqb3IiOiLsnLXtlansoITsnpDqs7XtlZnrtoAiLCJpYXQiOjE1OTQ4MzkzOTEsImV4cCI6MTU5ODQzNTc5MSwiaXNzIjoiYm9iYWUifQ.jxont3bUINSAtQt_F90KeE376WX-cZJoB5rzM2K7Ccg"
    ]
    
    
    func getSubject(course : [String], grade : [Int], credit : [Int], onDay : [Int], offDay : [Int], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        var apiString = ""
        
        for cour in course {
            apiString += "?course=\(cour)"
        }
        
        for g in grade {
              apiString += "?grade=\(g)"
        }
        
        for cre in credit {
              apiString += "?credit=\(cre)"
        }
        
        for on in onDay {
            apiString += "?onDay=\(on)"
        }
        
        for off in offDay {
            apiString += "?offDay=\(off)"
        }
        
        
        Alamofire.request(APIConstants.subject + apiString , method : .get, encoding: JSONEncoding.default, headers: header).responseJSON {
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
    
    func enrollSubejct(subjectIdx: Int, color: Int, scheduleIdx : Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
         print("hello2")
        print(makeParameter(subjectIdx, color, scheduleIdx))
        
        Alamofire.request(APIConstants.schoolScheudle, method : .post, parameters: makeParameter(subjectIdx, color, scheduleIdx), encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
             print("hello")
            
            switch response.result {
            case .success:
                
                print("success")
                
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.result.value else { return }
                let json = JSON(value)
                let networkResult = self.judge(type: 1, by: statusCode, json)
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

