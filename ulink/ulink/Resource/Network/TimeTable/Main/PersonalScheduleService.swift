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
        
        for(index, value) in list.enumerated(){
            
            let key = "schedule[\(index)]"
            let jsonData = try? encoder.encode(value)
            
            let jsonString = String(data: jsonData!, encoding: .utf8)
            let value = jsonString!
            
            print("value", value)
            resultList.append(value)

        }
        
        return ["scheduleList" : resultList]
        
        
        
        
//        var text = "["
//
//        for(index, value) in list.enumerated(){
//            text += makeListToString(value)
//
//            if index < list.count - 1{
//                text += ", "
//            }
//        }
//
//        text += "]"
//
//        let data = text.data(using: .utf8)!
//
//        return try! ["scheduleList" : JSON.init(data: data)]
//
//        do {
//            let f = try JSONDecoder().decode([Form].self, from: data)
//
//            print(f)
//            print(f[0])
//              return ["scheduleList" : f]
//        } catch {
//            print(error)
//
//        }
//
//        return ["scheduleList" : ""]
//
//
//
//        var result = [Dictionary<String,Any>]()
//
//        let data = text.data(using: .utf8)!
//        do {
//            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
//            {
//                result = jsonArray
//               print(jsonArray) // use the json here
//            } else {
//                print("bad json")
//            }
//        } catch let error as NSError {
//            print(error)
//        }
//
//        print("여기보세요~~~~~~", result)


    
    }
    
    private func makeListToString(_ model : PersonalScheduleModel)-> String{
        
        var text = "{\"name\" : \"\(model.name)\","
        text +=  "\"startTime\" : \"\(model.startTime)\","
        text +=  "\"endTime\" : \"\(model.endTime)\","
        text +=  "\"day\" : \(model.day),"
        text +=  "\"content\" : \"\(model.content)\","
        text +=  "\"color\" : \(model.color),"
        text +=  "\"scheduleIdx\" : \(model.scheduleIdx)}"
        
        return text
    }
    

    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
//        "token" : UserDefaults.standard.object(forKey: "token") as! String
        "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJuYW1lIjoi6rmA67O067CwIiwic2Nob29sIjoi7ZWc7JaR64yA7ZWZ6rWQIiwibWFqb3IiOiLsnLXtlansoITsnpDqs7XtlZnrtoAiLCJpYXQiOjE1OTQ4MzkzOTEsImV4cCI6MTU5ODQzNTc5MSwiaXNzIjoiYm9iYWUifQ.jxont3bUINSAtQt_F90KeE376WX-cZJoB5rzM2K7Ccg"
    ]
    
    func postPersonalScheudule(personalScheudleList: [PersonalScheduleModel], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        print("hello1")
        
        Alamofire.request(APIConstants.personalSchedule, method : .post, parameters: makeParameter(personalScheudleList), encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                
                   print("hello2")
                
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

struct Form: Codable {
    let name: String
    let day: Int
    let content: String
    let color : Int
    let startTime : String
    let endTime : String
    let scheduleIdx : Int

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case day = "day"
        case content = "content"
        case color = "color"
        case startTime = "startTime"
        case endTime = "endTime"
        case scheduleIdx = "scheduleIdx"
    }
}
