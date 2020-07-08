//
//  TimeTableController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TimeTableController: UIViewController {
    weak var timeTable: TimeTable!
    weak var collectionView : UICollectionView! {
        didSet {
            collectionView.isScrollEnabled = true
            collectionView.bounces = false
            collectionView.register(SubjectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        print("touchesBegan is called")
    }
}

extension TimeTableController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var minStartTimeHour : Int = 09
        var maxEndTimeHour : Int = 19

        if timeTable.subjectItems.count < 1 {
            minStartTimeHour = timeTable.defaultMinHour
            maxEndTimeHour = timeTable.defaultMaxHour
        }else {
            for(index, subjectItem) in timeTable.subjectItems.enumerated(){
                let tempStartTimeHour = Int(subjectItem.startTime.split(separator: ":")[0]) ?? 24
                let tempEndTimeHour = Int(subjectItem.endTime.split(separator: ":")[0]) ?? 00

                if index < 1 {
                    minStartTimeHour = tempStartTimeHour
                    maxEndTimeHour = tempEndTimeHour
                }else{
                    if tempStartTimeHour < minStartTimeHour{
                        minStartTimeHour = tempStartTimeHour
                    }

                    if tempEndTimeHour > maxEndTimeHour {
                        maxEndTimeHour = tempEndTimeHour
                    }
                }
            }
            maxEndTimeHour += 1
        }

        let subjectCount = maxEndTimeHour - minStartTimeHour + 1
        return (subjectCount + 1) * (timeTable.daySymbols.count + 1)
    }

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SubjectCell
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        let titleLabel = PaddingLabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))

//        backgroundView.layer.addBorder(edge: UIRectEdge.bottom, color: timeTable.borderColor, thickness: timeTable.borderWidth)
        backgroundView.backgroundColor = .clear
        backgroundView.tag = 9

        // 이게 뭘까?
        for view in cell.subviews {
            if view.tag == 9 {
                view.removeFromSuperview()
            }
        }

        cell.textLabel.textColor = UIColor.black

        if indexPath.row == 0 {
            titleLabel.text = ""
            cell.setNeedsDisplay()
            backgroundView.backgroundColor = UIColor.clear

        }else if indexPath.row < (timeTable.daySymbols.count + 1){
//            if indexPath.row < timeTable.daySymbols.count {
//                backgroundView.layer.addBorder(edge: UIRectEdge.top, color: timeTable.borderColor, thickness: timeTable.borderWidth)
//            }

//            cell.setNeedsDisplay()
//
//            titleLabel.text = timeTable.daySymbols[indexPath.row - 1]
//            titleLabel.textAlignment = .center
//            titleLabel.font = timeTable.symbolFont
//            titleLabel.textColor = timeTable.symbolFontColor
//            backgroundView.backgroundColor = UIColor.white

        } else if indexPath.row % (timeTable.daySymbols.count + 1) == 0 {
        
            let time = (timeTable.minimumSubjectStartTime ?? 9) - 1 + (indexPath.row / (timeTable.daySymbols.count + 1 ))
            if  time > 12 {
                titleLabel.text = "\(time - 12)"
            }else{
                titleLabel.text = "\(time)"
            }
            
            titleLabel.textAlignment = .center
            titleLabel.sizeToFit()
            titleLabel.frame = CGRect(x: 0, y:0, width: cell.frame.width, height: titleLabel.frame.height)
            titleLabel.font = timeTable.symbolTimeFont
            titleLabel.textColor = timeTable.symbolTimeFontColor

        } else {
            cell.textLabel.text = ""
            cell.setNeedsDisplay()
            backgroundView.layer.addBorder(edge: UIRectEdge.top, color: timeTable.borderColor, thickness: timeTable.borderWidth)
            backgroundView.backgroundColor = UIColor.white
        }

        backgroundView.addSubview(titleLabel)
//        backgroundView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panEmptySpace)))
        
        cell.addSubview(backgroundView)
        return cell
    }
    
    @objc func panEmptySpace(_ sender: UIPanGestureRecognizer){
        let view = collectionView
        
        let touchLocation = sender.location(in: view)
            
        let posiX = touchLocation.x
        let posiY = touchLocation.y
 
    }
}

extension TimeTableController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var minStartTimeHour : Int = 24
        var maxEndTimeHour : Int = 0

        if timeTable.subjectItems.count < 1 {
            minStartTimeHour = timeTable.defaultMinHour
            maxEndTimeHour = timeTable.defaultMaxHour
        } else {
            for (index, subjectItem) in timeTable.subjectItems.enumerated() {
                let tempStartTimeHour = Int(subjectItem.startTime.split(separator : ":")[0]) ?? 24
                let tempEndTimeHour = Int(subjectItem.endTime.split(separator : ":")[0]) ?? 00

                if index < 1 {
                    minStartTimeHour = tempStartTimeHour
                    maxEndTimeHour = tempEndTimeHour
                }else {
                    if tempStartTimeHour < minStartTimeHour{
                        minStartTimeHour = tempStartTimeHour
                    }

                    if tempEndTimeHour > maxEndTimeHour {
                        maxEndTimeHour = tempStartTimeHour
                    }
                }
            }
            maxEndTimeHour += 1
        }

        if indexPath.row == 0 {
            return CGSize(width: timeTable.widthOfTimeAxis , height: timeTable.heightOfDaySection)
        }else if indexPath.row < (timeTable.daySymbols.count + 1 ){
            return CGSize(width: timeTable.averageWidth, height : timeTable.heightOfDaySection)
        }else if indexPath.row % (timeTable.daySymbols.count + 1) == 0 {
            return CGSize(width: timeTable.widthOfTimeAxis, height: timeTable.subjectItemHeight)
        }else {
            return CGSize(width: timeTable.averageWidth, height: timeTable.subjectItemHeight)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected : \(indexPath.row)")
    }
}

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat){
        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: 0, height: self.frame.height)
            break
        default:
            break
        }
        border.backgroundColor = color.cgColor

        self.addSublayer(border)
    }
}
