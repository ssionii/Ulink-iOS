//
//  TimeTableService.swift
//  ulink
//
//  Created by 양시연 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

struct TimeTableService {
     static let shared = TimeTableService()
      
    func getMainTimeTable(completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "token" : UserDefaults.standard.string(forKey: "token")]
        let dataRequest = Alamofire.request(APIConstants.getMainTimeTable)
        
//        let dataRequest = Alamofire.request(APIConstants.signinURL, method  : .get , parameters: nil), encoding:JSONEncoding.default, headers: header)
           
           
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
       
       
       private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
           switch statusCode {
               
           case 200: return isUser(by: data)
           case 400: return .pathErr
           case 500: return .serverErr
           default: return .networkFail
           }
       }
       
       
       
       private func isUser(by data: Data) -> NetworkResult<Any> {
           let decoder = JSONDecoder()
           

           
           guard let decodedData = try? decoder.decode(SigninData.self, from: data) else { return .pathErr }
           guard let tokenData = decodedData.data else { return .requestErr(decodedData.message) }

           return .success(tokenData.accessToken,tokenData.uid)
       }
}
