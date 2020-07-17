//
//  LoginService.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/13.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Alamofire
import Foundation


struct SearchRecommendService {
    static let shared = SearchRecommendService()
    
    //UserDefaults.standard.string(forKey: "userID"
    
    var userDefaultToken: String = ""
    
    func openRecommendData(word: String, completion: @escaping (CalendarNetworkResult<Any>) -> Void) {
        if let userDefaultToken = UserDefaults.standard.string(forKey: "token") {
            let header: HTTPHeaders = ["Content-Type": "application/json", "token": userDefaultToken]
            
            var query: String = ""
            
            var queryWord = word.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            query = "?name=\(queryWord)"
            
            let dataRequest = Alamofire.request(APIConstants.searchURL + query, method: .get, encoding: JSONEncoding.default, headers: header)
            
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
        case 200: return getRecommendData(by: data)
        case 400: return .pathErr //오류난다
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func getRecommendData(by data: Data) -> CalendarNetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(SearchRecommendData.self, from: data) else { return .pathErr}
        guard let tokenData = decodedData.data else { return .requestErr }

        return .success(tokenData)
    }
}
