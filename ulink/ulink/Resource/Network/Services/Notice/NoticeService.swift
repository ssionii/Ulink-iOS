//
//  NoticeService.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct NoticeService {
    static let shared = NoticeService()

    
    
    
    
    
    func getSubjectNotice(subjectIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        
        
        guard let userToken = UserDefaults.standard.string(forKey: "token") else {return}
        
        let header: HTTPHeaders = ["token" : userToken,
                                   "Content-Type": "application/json"]
        let noticeURL : String = APIConstants.subjectNoticeURL + "/" + String(subjectIdx)
        let dataRequest = Alamofire.request(noticeURL, method  : .get, encoding:
            JSONEncoding.default, headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                
                let json = JSON(value)
                
                let networkResult = self.judge(by: statusCode, json)
                completion(networkResult)
            case .failure: completion(.networkFail)
            }
        }
    }
    
    
    private func judge(by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
        switch statusCode {
            
        case 200: return isSubject(by: json)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
    private func isSubject(by json: JSON) -> NetworkResult<Any> {
        
        let data = json["data"] as JSON
        
        let hwNotice = data["assignment"]
        let testNotice = data["exam"]
        let classNotice = data["lecture"]
        
        var noticeModelList = [[SubjectNoticeData]]()
        
        var hwList = [SubjectNoticeData]()
        
        var testList = [SubjectNoticeData]()
        
        var classList = [SubjectNoticeData]()
        
        var numberOfNotice : [Int] = [0,0,0]

        if hwNotice.arrayValue.count > 0
        {
            for i in 0...hwNotice.arrayValue.count-1
            {
                
                let noticeModel = SubjectNoticeData(
                    idx: hwNotice[i]["noticeIdx"].intValue,
                    Title: hwNotice[i]["title"].stringValue,
                    start: hwNotice[i]["startTime"].stringValue,
                    end: hwNotice[i]["endTime"].stringValue,
                    dateTime: hwNotice[i]["date"].stringValue)
                
                    
                hwList.append(noticeModel)
                
                
            }
        }
    

        if testNotice.arrayValue.count > 0
        {
            for j in 0...testNotice.arrayValue.count-1
            {
                
                let noticeModel = SubjectNoticeData(
                    idx: testNotice[j]["noticeIdx"].intValue,
                    Title: testNotice[j]["title"].stringValue,
                    start: testNotice[j]["startTime"].stringValue,
                    end: testNotice[j]["endTime"].stringValue,
                    dateTime: testNotice[j]["date"].stringValue)
                
                    
                testList.append(noticeModel)
            }
        }
        
        if classNotice.arrayValue.count > 0
        {
            
                for l in 0...classNotice.arrayValue.count-1
                {
                    
                    let noticeModel = SubjectNoticeData(
                        idx: classNotice[l]["noticeIdx"].intValue,
                        Title: classNotice[l]["title"].stringValue,
                        start: classNotice[l]["startTime"].stringValue,
                        end: classNotice[l]["endTime"].stringValue,
                        dateTime: classNotice[l]["date"].stringValue)
                    
                        
                    classList.append(noticeModel)
                    
                }
        }
        

        noticeModelList.append(hwList)
        noticeModelList.append(testList)
        noticeModelList.append(classList)
        
        
        
        numberOfNotice[0] = hwNotice.arrayValue.count
        numberOfNotice[1] = testNotice.arrayValue.count
        numberOfNotice[2] = classNotice.arrayValue.count
        
        

        
        
        return .success(noticeModelList,numberOfNotice)
    }
}

