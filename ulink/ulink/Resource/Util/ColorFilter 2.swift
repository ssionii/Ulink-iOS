//
//  ColorFilter.swift
//  ulink
//
//  Created by 양시연 on 2020/07/04.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class ColorFilter{
    
    var originalTheme : [UIColor] = [
        UIColor.periwinkleBlueTwo,
        UIColor.babyPurple,
        UIColor.lightblue,
        UIColor.powderPink,
        UIColor.periwinkleBlue,
        UIColor.skyBlueTwo,
        UIColor.pink,
        UIColor.easterPurple,
        UIColor.robinSEgg,
        UIColor.skyBlue
    ]

    
    func getColor(colorCode : Int) -> UIColor{
        return originalTheme[colorCode]
    }
    
    func getColorCount() -> Int {
        return originalTheme.count
    }
    
}
