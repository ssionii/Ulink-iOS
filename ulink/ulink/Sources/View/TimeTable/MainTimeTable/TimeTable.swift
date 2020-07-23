//
//  TimeTable.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//


/*
 
 시간표 클래스
 우리가 보는 시간표에 관한 모든 것을 여기서 관리!
 ex) 관리할 수 있는 속성 및 메소드는 이름을 보면 알 겁니다!
 
 */





import Foundation
import UIKit

public protocol TimeTableDelegate {
    
    func timeTable(timeTable: TimeTable, selectedSubjectIdx: Int, isSubject : Bool)
    
    func timeTableHintCount(hintCount : Int)
}

public protocol TimeTableDataSource {
    func timeTable(timeTable: TimeTable, at dayPerIndex : Int) -> String
    func numberOfDays(in timeTable: TimeTable) -> Int
    func subjectItems(in timeTable: TimeTable) -> [SubjectModel]
}

public func getWidth() -> Int{
    
    let bounds = UIScreen.main.bounds
    let height = bounds.size.height
    
    switch height{
        
    case 450.0 ... 667.0 : // 6 6s 7 8
        
        print("2번")
        return 19
        
    case 730.0 ... 810.0: // 6s+, 7+ 8+
        print("3번")
        return 19
        
    case 812.0 ... 890.0: //X, XS
        print("4번")
        //11pro
        return 19
    
    case 896.0:         // XS MAX
        print("5번")
        //11
        return 32
    default:
        print("6번")
        return 19
        
    }
}


@IBDesignable public class TimeTable : UIView {
    public var controller = TimeTableController()
    public var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    public var defaultMinHour : Int = 9
    public var defaultMaxHour : Int = 19

    public var minimumSubjectStartTime : Int?
    public var subjectItemHeight : CGFloat = 52.0
    
    public var userDaySymbol : [String]?
    public var delegate : TimeTableDelegate?
    public var dataSource : TimeTableDataSource?

    private var subjectCells = [SubjectCell]()
    private var colorPicker = ColorPicker()
    
    // 드래그로 시간표 추가시 그 시간표를 잠시 저장해 놓는 리스트
    public var tempUserScheduleList : [TimeInfoModel] = []
    
    private var startPositionX : CGFloat = 0
    private var startPositionY : CGFloat = 0

    public var startDay = TimeTableDay.monday {
        didSet {
            makeTimeTable()
        }
    }
    
    // 시간표에 그려질 과목들
    public var subjectItems = [SubjectModel](){
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

    @IBInspectable public var symbolFontColor = UIColor.brownGrey {
        
        didSet { makeTimeTable() }
    }

    @IBInspectable public var symbolFontSize = CGFloat(14){
        didSet { makeTimeTable() }
    }
    
    @IBInspectable public var symbolFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 14){
        didSet { makeTimeTable() }
    }

    // 이거 개발 못할 때 위에 월,화,,,금 써져있는거 배경으로 radius 들어가 있는 배경을 이미지로 박을라고 위 DaySection 높이 0으로 만들고 스토리 보드에서 label로 월,화,,,금 써줌. 근데 이거 고쳐야 댐
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

        let startIndex = self.startDay.rawValue
        daySymbolText.rotate(shiftingToStart: startIndex)
        return daySymbolText
    }
    
    @IBInspectable public var widthOfTimeAxis = CGFloat(getWidth()){
           didSet {
            makeTimeTable() }
       }
    
    var averageWidth : CGFloat{
        return (self.collectionView.frame.width - self.widthOfTimeAxis) / CGFloat(self.daySymbols.count)
         
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
    
    
    // MARK:- function들

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

    // 제일 중요한 timeTable을 그려주는 함수!
    // 찬찬히 읽으면 다 이해 됩니다!
    private func makeTimeTable(){
        var minStartTimeHour : Int = 24
        var maxEndTimeHour : Int = 0

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

        let subjectItems = self.dataSource?.subjectItems(in: self) ?? [SubjectModel]()

        minStartTimeHour = defaultMinHour
        maxEndTimeHour = defaultMaxHour

        if subjectItems.count >= 1 {
            for (index, subjectItem) in subjectItems.enumerated(){
                
                let tempStartTimeHour = Int(subjectItem.startTime[0].split(separator : ":")[0]) ?? 24
                let tempEndTimeHour = Int(subjectItem.endTime[0].split(separator : ":")[0]) ?? 00

                if index >= 1 {
                    if tempStartTimeHour < minStartTimeHour {
                        minStartTimeHour = tempStartTimeHour
                    }

                    if tempEndTimeHour > maxEndTimeHour {
                        maxEndTimeHour = tempEndTimeHour
                        print("들어옴! \(tempEndTimeHour), \(maxEndTimeHour)")
                    }
                }
            }
            maxEndTimeHour += 1
        }
        minimumSubjectStartTime = minStartTimeHour

        // subject 그리기
        for(index, subjectItem) in subjectItems.enumerated() {
            let dayCount = dataSource?.numberOfDays(in : self) ?? 6
            let weekdayIndex = (subjectItem.subjectDay[0] - startDay.rawValue + dayCount) % dayCount

            let subjectStartHour = Int(subjectItem.startTime[0].split(separator: ":")[0]) ?? 09
            let subjectStartMin = Int(subjectItem.startTime[0].split(separator: ":")[1]) ?? 00

            let subjectEndHour = Int(subjectItem.endTime[0].split(separator: ":")[0]) ?? 21
            let subjectEndMin = Int(subjectItem.endTime[0].split(separator: ":")[1]) ?? 00
            let averageHeight = subjectItemHeight

            // subject cell의 x position과 y position
            let position_x = collectionView.bounds.minX + widthOfTimeAxis + averageWidth * CGFloat(weekdayIndex) + rectEdgeInsets.left
            let position_y = collectionView.frame.minY + heightOfDaySection + averageHeight * CGFloat(subjectStartHour - minStartTimeHour) + CGFloat((CGFloat(subjectStartMin) / 60) * averageHeight) + rectEdgeInsets.top

            let width = averageWidth - ( rectEdgeInsets.left + rectEdgeInsets.right )
            let height = averageHeight * CGFloat(subjectEndHour - subjectStartHour) + CGFloat((CGFloat(subjectEndMin - subjectStartMin) / 60) * averageHeight) - rectEdgeInsets.top - rectEdgeInsets.bottom

            let view = UIView(frame: CGRect(x: position_x, y: position_y, width: width, height: height))
            
            view.backgroundColor = colorPicker.getColor(subjectItem.backgroundColor).color
            view.layer.cornerRadius = 8

            let label = PaddingLabel(frame: CGRect(x: textEdgeInsets.left, y: textEdgeInsets.top, width: view.frame.width - textEdgeInsets.right, height: view.frame.height - textEdgeInsets.top))
            let name = subjectItem.subjectName
            
            let attrStr = NSMutableAttributedString(string: name + "\n" + subjectItem.content[0], attributes: [NSAttributedString.Key.font: subjectRoomNameFont!])
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
            view.tag = index
                
            view.addSubview(label)
            collectionView.addSubview(view)

        }
    }
    
    // 여기서 부터 드래그로 직접 추가를 위한 부분
    var baseXList : [CGFloat] = []
    var baseYList : [CGFloat] = []
    var baseTimeList : [String] = []
    
    // 드래그시 어두운 음영처리 되는 부분을 timeTableHint라고 명명하였음
    // 드래그로 직접 추가 기능에서 long press로 시작점 찍었을 때 호출되는 함수
    func makeStartPointFromDrag(input_x : CGFloat, input_y : CGFloat){
        
        var tempUserSchedule = TimeInfoModel.init()
        
        for weekdayIndex in 0 ... 6 {
            let base_x = collectionView.bounds.minX + widthOfTimeAxis + averageWidth * CGFloat(weekdayIndex) + rectEdgeInsets.left
            
            self.baseXList.append(base_x)
        }
        
        for i in 0 ... 6 {
            if i != 6 && self.baseXList[i] <= input_x && self.baseXList[i + 1] >= input_x {
                
                startPositionX = self.baseXList[i]
                tempUserSchedule.weekDay = i
                break
            }
        }
        
        let averageHeight = subjectItemHeight
        
        for hour in 9 ... 21 {
            for min in 0 ... 3 {
                let base_y = collectionView.frame.minY + heightOfDaySection + averageHeight * CGFloat(hour - 9) +
                    CGFloat((CGFloat(min * 15) / 60) * averageHeight)
                    
                let baseTime = String(hour) + ":" + String(min * 15)
                baseTimeList.append(baseTime)
    
                baseYList.append(base_y)
            }
        }
        
        for i in 0 ... baseYList.count - 1 {
                   
            if i != baseYList.count - 1 && baseYList[i] <= input_y && baseYList[i + 1] >= input_y {
                startPositionY = baseYList[i]
                
                tempUserSchedule.startTime = baseTimeList[i]
                break
            }
        }
        
        
        tempUserScheduleList.append(tempUserSchedule)
        
        // 드래그 시작하면 오른쪽 상단 버튼 확정 -> 추가로 변경
        delegate?.timeTableHintCount(hintCount: tempUserScheduleList.count)
    }
        
    // 드래그 시 음영을 그려주는 부분
    func makeHintTimeTableForDrag(input_x : CGFloat, input_y : CGFloat){
        
        let count = tempUserScheduleList.count
        for subview in collectionView.subviews{
            if (subview.tag == count * 100){
                subview.removeFromSuperview()
            }
        }
        
        let width = averageWidth - ( rectEdgeInsets.left + rectEdgeInsets.right )
        
        var position_y : CGFloat = 0
        
        for i in 0 ... baseYList.count - 1 {
            if i != baseYList.count - 1 && baseYList[i] <= input_y && baseYList[i + 1] >= input_y {
                position_y = baseYList[i]
                tempUserScheduleList[count - 1].endTime = baseTimeList[i]
                break
            }
        }
        
        tempUserScheduleList[count - 1].timeIdx = count
        
        let height = position_y - startPositionY

        let view = UIView(frame: CGRect(x: startPositionX, y: startPositionY, width: width, height: height))
        view.backgroundColor = UIColor.black
        view.alpha = 0.3
        view.tag = count * 100
        view.layer.cornerRadius = 8
        
        collectionView.addSubview(view)
    
    }

    
    // 시간표 생성 뷰에서 과목을 클릭했을 때 위 시간표에 음영을 그려주는 함수
    func makeHintTimeTable(day: [Int], startTime: [String], endTime : [String]){
        
        collectionView.reloadData()
        let minStartTimeHour : Int = defaultMinHour
        
        var upperPosiY = collectionView.frame.height
    
        if day.count > 0 {
            for i in 0 ... day.count - 1 {
                
                let startTime = startTime[i]
                let endTime  = endTime[i]
                
                let weekdayIndex = day[i]
                
                let subjectStartHour = Int(startTime.split(separator: ":")[0]) ?? 09
                let subjectStartMin = Int(startTime.split(separator: ":")[1]) ?? 00
                let subjectEndHour = Int(endTime.split(separator: ":")[0]) ?? 21
                let subjectEndMin = Int(endTime.split(separator: ":")[1]) ?? 00
                
                let averageHeight = subjectItemHeight
                
                let position_x = collectionView.bounds.minX + widthOfTimeAxis + averageWidth * CGFloat(weekdayIndex) + rectEdgeInsets.left
                let position_y = collectionView.frame.minY + heightOfDaySection + averageHeight * CGFloat(subjectStartHour - minStartTimeHour) + CGFloat((CGFloat(subjectStartMin) / 60) * averageHeight) + rectEdgeInsets.top
            
                if position_y < upperPosiY {
                    upperPosiY = position_y
                }
                
                let width = averageWidth - ( rectEdgeInsets.left + rectEdgeInsets.right )
                let height = averageHeight * CGFloat(subjectEndHour - subjectStartHour) + CGFloat((CGFloat(subjectEndMin - subjectStartMin) / 60) * averageHeight) - rectEdgeInsets.top - rectEdgeInsets.bottom

                let view = UIView(frame: CGRect(x: position_x, y: position_y, width: width, height: height))
                view.backgroundColor = UIColor.black
                view.alpha = 0.3
//                view.tag = removeTag
//                removeTag += 1

                view.layer.cornerRadius = 8
                
                collectionView.addSubview(view)
                
               
            }
        }
        
        collectionView.setNeedsDisplay()
        
        collectionView.scrollRectToVisible(CGRect(x: 0, y: upperPosiY, width: collectionView.frame.width, height: collectionView.frame.height), animated: true)
        
    }
    
    // hintTable 지워주는 함수. hintTable은 UICollectionViewCell이 아니므로 얘가 아닌 애들을 다 지운다.
    func removeHintTable(){
        
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
        
    }
    
    // 드래그로 직접 추가시 되돌리기 버튼을 통해 가장 마지막으로 드래그된 hintTable을 지워줌
       public func removeLastSchedule(){
           let count = tempUserScheduleList.count
           if count > 0 {
               for subview in collectionView.subviews{
                   if subview.tag == count * 100 {
                       subview.removeFromSuperview()
                   }
               }
               self.tempUserScheduleList.remove(at: count - 1 )
           }
           
           delegate?.timeTableHintCount(hintCount: tempUserScheduleList.count)
       }
       

    // 시간표안의 과목을 클릭했을 때 호출되는 함수
    // 메인뷰에서 과목 detail을 볼 때 쓰임
    @objc func lectureTapped(_ sender: UITapGestureRecognizer){
    
        reloadData()
        
        let subject = subjectItems[(sender.view!).tag]
        self.delegate?.timeTable(timeTable: self, selectedSubjectIdx: subject.subjectIdx, isSubject: subject.isSubject)
        
    }
    
    // 과목 지우기
    public func removeSchedule(num : Int){
        for subview in collectionView.subviews{
            let tag = tempUserScheduleList[num - 1].timeIdx
            
            if subview.tag == tag * 100{
                subview.removeFromSuperview()
            }
        }
        
         self.tempUserScheduleList.remove(at: num - 1)
        
        delegate?.timeTableHintCount(hintCount: tempUserScheduleList.count)
        
    }

    // subjectItems를 초기화 (새로고침 느낌)
    public func reloadData() {
        subjectItems = self.dataSource?.subjectItems(in: self) ?? [SubjectModel]()
        
    }
    
    // timeTable 다시 그리기
    public func reDrawTimeTable(){
    
        self.tempUserScheduleList.removeAll()
        makeTimeTable()

    }
    
    // 이번에 쓰일 과목의 background 색 뽑아주는 함수
    public func getColorCount() -> Int{
        
        let mainColorList = [9, 12, 6, 13, 10, 7, 14, 1, 5, 8]
        
        var colorCount = 0
        
        let sortedSubjectItems = subjectItems.sorted(by: {$0.subjectIdx < $1.subjectIdx})
        
        if(sortedSubjectItems.count > 1){
            for i in 0 ... sortedSubjectItems.count - 2 {
                if sortedSubjectItems[i].subjectIdx != sortedSubjectItems[i + 1].subjectIdx {
                    colorCount += 1
                }
            }
            colorCount += 1
        }else if (sortedSubjectItems.count == 1){
            colorCount = 1
        }
        
        return mainColorList[colorCount]
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

