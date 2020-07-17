//
//  TimeInfo.swift
//  ulink
//
//  Created by 양시연 on 2020/07/11.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import UIKit

public struct ColorList{
    var color: UIColor
    var colorName: String
    
    init(color: UIColor, colorName: String){
        self.color = color
        self.colorName = colorName
    }
}

public class ColorPicker{
   let colorList = [
    ColorList.init(color: UIColor.dullYellow, colorName: "올리브 그린"),
    ColorList.init(color: UIColor.greenishBeige, colorName: "말차 그린"),
    ColorList.init(color: UIColor.paleOliveGreen, colorName: "포레스트 그린"),
    ColorList.init(color: UIColor.paleTeal, colorName: "제주 그린"),
    ColorList.init(color: UIColor.seafoamBlue, colorName:"민트 그린"),
    ColorList.init(color: UIColor.robinSEgg, colorName: "오션 블루"),
    ColorList.init(color: UIColor.lightblue, colorName: "스카이 블루"),
    ColorList.init(color: UIColor.skyBlueTwo, colorName: "마티니 블루"),
    ColorList.init(color: UIColor.skyBlue, colorName: "진 블루"),
    ColorList.init(color: UIColor.periwinkleBlueTwo, colorName: "애쉬 퍼플"),
    ColorList.init(color: UIColor.periwinkleBlue, colorName: "문라이트 퍼플"),
    ColorList.init(color: UIColor.easterPurple, colorName: "와인 퍼플"),
    ColorList.init(color: UIColor.babyPurple, colorName: "라일락 퍼플"),
    ColorList.init(color: UIColor.powderPink, colorName: "베이비 핑크"),
    ColorList.init(color: UIColor.pink, colorName: "라즈베리 핑크"),
    ColorList.init(color: UIColor.peachyPink, colorName: "코랄 핑크"),
    ColorList.init(color: UIColor.peachyPinkTwo, colorName: "자몽 오렌지"),
    ColorList.init(color: UIColor.apricot, colorName: "감귤 오렌지"),
    ColorList.init(color: UIColor.paleGold, colorName: "망고 오렌지"),
    ColorList.init(color: UIColor.dullYellowTwo, colorName: "허니 옐로우")]
    
    func getColor(_ index: Int) -> ColorList {
        return colorList[index]
    }
    
    func getColorList() -> [ColorList] {
        return colorList
    }
}
