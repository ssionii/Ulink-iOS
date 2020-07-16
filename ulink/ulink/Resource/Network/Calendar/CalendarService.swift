//
//  LoginService.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/13.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Alamofire
import Foundation


struct CalendarService {
    static let shared = CalendarService()
    
    //UserDefaults.standard.string(forKey: "userID"
    
    var userDefaultToken: String = ""
    
    func openCalendarData(start: String, end: String, completion: @escaping (CalendarNetworkResult<Any>) -> Void) {
        if let userDefaultToken = UserDefaults.standard.string(forKey: "token") {
            let header: HTTPHeaders = ["Content-Type": "application/json", "token": userDefaultToken]
            
            let query = "?start=\(start)&end=\(end)"
            
            let dataRequest = Alamofire.request(APIConstants.calendarURL + query, method: .get, encoding: JSONEncoding.default, headers: header)
            
            dataRequest.responseData { dataResponse in
                switch dataResponse.result {
                case .success:
                    guard let statusCode = dataResponse.response?.statusCode else { return }
                    guard let value = dataResponse.result.value else { return }
                    let networkResult = self.judge(by: statusCode, value)
                    completion(networkResult)
                case .failure: completion(.networkFail)
                }
            }
        }
    }
    
    
    private func judge(by statusCode: Int, _ data: Data) -> CalendarNetworkResult<Any> {
        switch statusCode {
            
        case 200: return getCalendarData(by: data)
        case 400: return .pathErr //오류난다
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
    private func getCalendarData(by data: Data) -> CalendarNetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(CalendarData.self, from: data) else { return .pathErr}
        guard let tokenData = decodedData.data else { return .requestErr }

        return .success(tokenData)
    }
}
