import Foundation

struct APIConstants {
     
    static let baseURL = "http://52.78.27.117:3000"
    static let signinURL = APIConstants.baseURL + "/user/signin"
    static let signupURL = APIConstants.baseURL + "/user/signup"
    
    static let timeTable = APIConstants.baseURL + "/schedule"
    static let mainTimeTable = APIConstants.baseURL + "/schedule/main"
    static let listTimeTable = APIConstants.baseURL + "/schedule/list"
    static let specificTimeTable = APIConstants.baseURL + "/schedule/specific"
    static let personalSchedule = APIConstants.baseURL + "/schedule/personal"
    static let schoolScheudle = APIConstants.baseURL + "/schedule/school"
    static let subject = APIConstants.baseURL + "/subject"
    static let cart = APIConstants.baseURL + "/cart"
    static let search = APIConstants.baseURL + "/subject/search"
    static let name = APIConstants.baseURL + "/schedule/name"
    
    static let subjectNoticeURL = APIConstants.baseURL + "/notice/subject"
    static let subjectDetailNoticeURL = APIConstants.baseURL + "/notice"
    static let calendarURL = APIConstants.baseURL + "/notice"
    static let searchURL = APIConstants.baseURL + "/subject/recommend"
    static let chatURL = APIConstants.baseURL + "/chat"
    
    
    static let courseURL = APIConstants.baseURL + "/subject/course"
}
