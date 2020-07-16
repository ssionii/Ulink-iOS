import Foundation

struct APIConstants {
     
    static let baseURL = "http://52.78.27.117:3000"
    static let signinURL = APIConstants.baseURL + "/user/signin"
    static let signupURL = APIConstants.baseURL + "/user/signup"
    
    static let timeTable = APIConstants.baseURL + "/schedule"
    static let mainTimeTable = APIConstants.baseURL + "/schedule/main"
     static let listTimeTable = APIConstants.baseURL + "/schedule/list"
    static let specificTimeTable = APIConstants.baseURL + "/schedule/specific"
}
