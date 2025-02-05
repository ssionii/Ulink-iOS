//
//  TimeTable.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import UIKit

public protocol TimeTableDelegate {
    func timeTable(timeTable: TimeTable, didSelectSubject selectedSubject: Subject)
}

public protocol TimeTableDataSource {
    func timeTable(timeTable: TimeTable, at dayPerIndex : Int) -> String
    func numberOfDays(in timeTable: TimeTable) -> Int
    func subjectItems(in timeTable: TimeTable) -> [Subject]
}

@IBDesignable public class TimeTable : UIView {
    private var controller = TimeTableController()
    private var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    public let defaultMinHour : Int = 9
    public let defaultMaxHour : Int = 21

    public var minimumSubjectStartTime : Int?
    public var subjectItemHeight : CGFloat = 50.0
    
    public var userDaySymbol : [String]?
    public var delegate : TimeTableDelegate?
    public var dataSource : TimeTableDataSource?

    private var subjectCells = [SubjectCell]()
    private var colorFilter = ColorFilter.init()

    public var startDay = TimeTableDay.monday {
        didSet {
            makeTimeTable()
        }
    }
    
    public var subjectItems = [Subject](){
        didSet{ makeTimeTable() }
    }


    // option setter
   
    
    public var timeTableBackgroundColor = UIColor.black{
        didSet{
            collectionView.backgroundColor = backgroundColor
        }
    }

    @IBInspectable public var borderWidth = CGFloat(1){
        didSet { makeTimeTable() }
    }

    @IBInspectable public var borderColor = UIColor.veryLightPink {
        didSet { makeTimeTable() }
    }

    @IBInspectable public var borderCornerRadius = CGFloat(0){
        didSet { makeTimeTable() }
    }

    // top symbol
    @IBInspectable public var symbolFontColor = UIColor.brownGrey {
        
        didSet { makeTimeTable() }
    }

    @IBInspectable public var symbolFontSize = CGFloat(14){
        didSet { makeTimeTable() }
    }
    
    @IBInspectable public var symbolFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 14){
        didSet { makeTimeTable() }
    }

    @IBInspectable public var heightOfDaySection = CGFloat(0){
        didSet { makeTimeTable() }
    }

    @IBInspectable public var weekDayTextColor = UIColor.black {
        didSet { makeTimeTable() }
    }

      public var daySymbols: [String] {
        var daySymbolText = [String]()

        if let count = self.dataSource?.numberOfDays(in: self) {
            for index in 0..<count {
                let text = self.dataSource?.timeTable(timeTable: self, at: index) ?? Calendar.current.shortStandaloneWeekdaySymbols[index]
                daySymbolText.append(text)
            }
        }

    //        daySymbolText = self.userDaySymbol ?? Calendar.current.shortStandaloneWeekdaySymbols

        let startIndex = self.startDay.rawValue - 1
        daySymbolText.rotate(shiftingToStart: startIndex)
        return daySymbolText
    }
    
    @IBInspectable public var widthOfTimeAxis = CGFloat(19){
           didSet {
            print(widthOfTimeAxis)
            makeTimeTable() }
       }

    var averageWidth : CGFloat {
        return (collectionView.frame.width - widthOfTimeAxis) / CGFloat(daySymbols.count)
    }

    // left time
    @IBInspectable public var symbolTimeFontColor = UIColor.brownGreyTwo{
        didSet { makeTimeTable() }
    }

    @IBInspectable public var symbolTimeFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 14){
           didSet { makeTimeTable() }
       }
    
    // subject
    @IBInspectable public var subjectNameFontColor = UIColor.white{
        didSet { makeTimeTable() }
    }

    @IBInspectable public var subjectNameFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 12){
        didSet { makeTimeTable() }
    }

    @IBInspectable public var symbolTextAlignment = NSTextAlignment.center {
        didSet {
            self.makeTimeTable()
        }
    }
    
    @IBInspectable public var subjectRoomNameFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 8){
        didSet{ makeTimeTable() }
    }
    
    @IBInspectable public var subjectRoomNameFontColor = UIColor.white {
        didSet{ makeTimeTable() }
    }
    
    private var rectEdgeInsets = UIEdgeInsets(top: 3, left: 2, bottom: 2, right: 2){
        didSet { self.makeTimeTable() }
    }

    private var textEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 4){
        didSet { self.makeTimeTable() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder aDecoder: NSCoder){
        super.init(coder : aDecoder)
        initialize()
    }

    private func initialize(){
        controller.timeTable = self
        controller.collectionView = collectionView

        collectionView.dataSource = controller
        collectionView.delegate = controller
        collectionView.backgroundColor = backgroundColor

        addSubview(collectionView)

        makeTimeTable()
    }

    public override func layoutSubviews(){
        super.layoutSubviews()

        collectionView.frame = bounds
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()

        makeTimeTable()
    }

    private func makeTimeTable(){
        var minStartTimeHour : Int = 24
        var maxEndTimeHour : Int = 0

//        collectionView.scrollToItem(at: IndexPath(row: 0, section : 0), at: .top, animated: false)

        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()

        for subview in collectionView.subviews{
            if !(subview is UICollectionViewCell){
                subview.removeFromSuperview()
            }
        }

        for subview in subviews {
            if !(subview is UICollectionView){
                subview.removeFromSuperview()
            }
        }

        let subjectItems = self.dataSource?.subjectItems(in: self) ?? [Subject]()

        minStartTimeHour = defaultMinHour
        maxEndTimeHour = defaultMaxHour

        if subjectItems.count >= 1 {
            for (index, subjectItem) in subjectItems.enumerated(){
                let tempStartTimeHour = Int(subjectItem.startTime.split(separator : ":")[0]) ?? 24
                let tempEndTimeHour = Int(subjectItem.endTime.split(separator : ":")[0]) ?? 00

                if index >= 1 {
                    if tempStartTimeHour < minStartTimeHour {
                        minStartTimeHour = tempStartTimeHour
                    }

                    if tempEndTimeHour > maxEndTimeHour {
                        maxEndTimeHour = tempEndTimeHour
                    }
                }
            }
            maxEndTimeHour += 1
        }
        minimumSubjectStartTime = minStartTimeHour

        // subject 그리기
        for(index, subjectItem) in subjectItems.enumerated() {
            let dayCount = dataSource?.numberOfDays(in : self) ?? 6
            let weekdayIndex = (subjectItem.subjectDay.rawValue - startDay.rawValue + dayCount) % dayCount

            let subjectStartHour = Int(subjectItem.startTime.split(separator: ":")[0]) ?? 09
            let subjectStartMin = Int(subjectItem.startTime.split(separator: ":")[1]) ?? 00

            let subjectEndHour = Int(subjectItem.endTime.split(separator: ":")[0]) ?? 21
            let subjectEndMin = Int(subjectItem.endTime.split(separator: ":")[1]) ?? 00
            let averageHeight = subjectItemHeight

            // subject cell의 x position과 y position
            let position_x = collectionView.bounds.minX + widthOfTimeAxis + averageWidth * CGFloat(weekdayIndex) + rectEdgeInsets.left
            let position_y = collectionView.frame.minY + heightOfDaySection + averageHeight * CGFloat(subjectStartHour - minStartTimeHour) + CGFloat((CGFloat(subjectStartMin) / 60) * averageHeight) + rectEdgeInsets.top

            let width = averageWidth - ( rectEdgeInsets.left + rectEdgeInsets.right )
            let height = averageHeight * CGFloat(subjectEndHour - subjectStartHour) + CGFloat((CGFloat(subjectEndMin - subjectStartMin) / 60) * averageHeight) - rectEdgeInsets.top - rectEdgeInsets.bottom

            let view = UIView(frame: CGRect(x: position_x, y: position_y, width: width, height: height))
            view.backgroundColor = colorFilter.getColor(colorCode: subjectItem.backgroundColor)
            view.layer.cornerRadius = 8

            let label = PaddingLabel(frame: CGRect(x: textEdgeInsets.left, y: textEdgeInsets.top, width: view.frame.width - textEdgeInsets.right, height: view.frame.height - textEdgeInsets.top))
            let name = subjectItem.subjectName
            
            let attrStr = NSMutableAttributedString(string: name + "\n" + subjectItem.roomName, attributes: [NSAttributedString.Key.font: subjectRoomNameFont!])
            attrStr.setAttributes([NSAttributedString.Key.font: subjectNameFont!], range: NSRange(0..<name.count))

            label.attributedText = attrStr
            label.textColor = subjectItem.textColor ?? UIColor.white
            label.numberOfLines = 0
            label.textAlignment = .left
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.sizeToFit()
            label.frame = CGRect(x: textEdgeInsets.left, y: textEdgeInsets.top, width: view.frame.width - textEdgeInsets.left - textEdgeInsets.right, height: label.bounds.height + 40)
            label.sizeToFit()
            label.frame = CGRect(x: textEdgeInsets.left, y: textEdgeInsets.top, width: view.frame.width - textEdgeInsets.left - textEdgeInsets.right, height: label.bounds.height)

            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lectureTapped)))
            
            view.isUserInteractionEnabled = true
            view.addSubview(label)
            collectionView.addSubview(view)
            label.tag = index
            view.tag = index
        }
    }

    @objc func lectureTapped(_ sender: UITapGestureRecognizer){
        
        print((sender.view!).tag)
//        let subject = subjectItems[(sender.view!).tag]
//        self.delegate?.timeTable(timeTable: self, didSelectSubject : subject)
    }
    


    public func reloadData() {
        subjectItems = self.dataSource?.subjectItems(in: self) ?? [Subject]()
    }
    
}

extension Array {
    func rotated(shiftingToStart middle: Index) -> Array {
        return Array(suffix(count - middle) + prefix(middle))
    }

    mutating func rotate(shiftingToStart middle: Index){
        self = rotated(shiftingToStart: middle)
    }
}

extension String {
    func truncated(_ length: Int) -> String {
        let end = index(startIndex, offsetBy: length, limitedBy: endIndex) ?? endIndex
        return String(self[..<end])
    }

    mutating func truncate(_ length: Int){
        self = truncated(length)
    }
}

extension UILabel {
    func textWidth() -> CGFloat{
        return UILabel.textWidth(label: self)
    }

    class func textWidth(label: UILabel) -> CGFloat{
        return textWidth(label: label, text: label.text!)
    }

    class func textWidth(label: UILabel, text: String) -> CGFloat{
        return textWidth(font: label.font, text: text)
    }

    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString

        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)

        return ceil(labelSize.width)
    }
}

