//
//  ClassModel.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation




class ClassModel : NSObject {

    var className : String?
//    var uid : String?
    var key : String?
    
    var image : classImage
    
    
    
    
    init(name : String, key : String, image:classImage)
    {
        self.className = name
        self.key = key
        self.image = image
    }   


    
}



enum classImage{
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    
    func getImageName() -> String{
        switch self{
            case .one:
                return "ioClassImgProfile1"
            case .two:
                return "ioClassImgProfile2"
            case .three:
                return "ioClassImgProfile3"
            case .four:
                return "ioClassImgProfile4"
            case .five:
                return "ioClassImgProfile5"
            case .six:
                return "ioClassImgProfile6"
            case .seven:
                return "ioClassImgProfile7"
            default :
                return "ioClassImgProfile1"
        }
    }
}
