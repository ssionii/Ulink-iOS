//
//  CalendarViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/03.
//  Copyright © 2020 송지훈. All rights reserved.
//
import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarSubView: UIView!
    
    var monthLabels = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    var numOfDate = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    //오늘 날짜 데이터
    let cal = Calendar(identifier: .gregorian)
    let today = Date()
    var todayMonth = Calendar.current.component(.month, from: Date())
    var currentMonth: Int = 0
    var todayYear = Calendar.current.component(.year, from: Date())
    var currentYear: Int = 0
    var todayDate = Calendar.current.component(.day, from: Date())
    
    let eventTitle = ["정보처리기사", "소프트웨어공학", "영상처리", "식생활문화"]
    let eventColor = [UIColor.powderPink, UIColor.lightblue, UIColor.periwinkleBlue, UIColor.pink]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = todayMonth
        currentYear = todayYear
        
        calendarSubView.layer.cornerRadius = 30
        monthLabel.text = String(currentMonth) + "월"
        
        if (todayYear % 4 == 0){
            numOfDate[1] = 29
        } else {
            numOfDate[1] = 28
        }
        
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
    }
    
    func getFirstWeekDay() -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let dateString = "01-" + String(currentMonth) + "-" + String(currentYear)
        let myDay = dateFormatter.date(from: dateString)
        let first = cal.dateComponents([.weekday], from: myDay!)
        
        let firstWeekDay = first.weekday!
        return firstWeekDay
    }
    
    func getLastDay() -> Int{
        
        var last: Int
        
        if (currentMonth == 0){
            last = numOfDate[11]
        } else if (currentMonth == 1){
            last = numOfDate[currentMonth - 1]
        } else {
            last = numOfDate[currentMonth - 1]
        }
        
        return last
    }
    
    func getLastOfLastDay() -> Int {
        var lastOfLast: Int
        
        if (currentMonth == 0){
            lastOfLast = numOfDate[10]
        } else if (currentMonth == 1){
            lastOfLast = numOfDate[11]
        } else {
            lastOfLast = numOfDate[currentMonth - 2]
        }
        
        return lastOfLast
    }
    
    @IBAction func clickNextBtn(_ sender: Any) {
        
        if (currentMonth == 12) {
            currentMonth = 1
            currentYear += 1
            
            if (currentYear % 4 == 0){
                numOfDate[1] = 29
            } else {
                numOfDate[1] = 28
            }
            
        } else {
            currentMonth += 1
        }
        
        monthLabel.text = String(currentMonth) + "월"
        calendarCollectionView.reloadData()
    }
    
    @IBAction func clickPrevBtn(_ sender: Any) {
        if (currentMonth == 1) {
            currentMonth = 12
            currentYear -= 1
            
            if (currentYear % 4 == 0){
                numOfDate[1] = 29
            } else {
                numOfDate[1] = 28
            }
            
        } else {
            currentMonth -= 1
        }
        
        monthLabel.text = String(currentMonth) + "월"
        calendarCollectionView.reloadData()
    }
    
    //collectionview layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 8)/7, height: 126)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //collectionview cell 띄우기
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let last = getLastDay()
        let first = getFirstWeekDay() - 1
        
        if (last + first > 35){
            return 42
        } else if (last + first == 28){
            return 28
        } else {
            return 35
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.identifier, for: indexPath) as? DayCell else {
        return UICollectionViewCell() }
        
        let first = getFirstWeekDay() - 1
        
        
        let last = getLastDay()
        let lastOfLast = getLastOfLastDay()
        
        
        if (indexPath.row >= 0 && indexPath.row < first){
            //저번달~
            cell.setDayCell(firstDay: lastOfLast - first + indexPath.row, textColor: 0)
        } else if (indexPath.row >= first && indexPath.row < last + first){
            //이번달~
            if ((indexPath.row % 7) == 0){
                if (((indexPath.row - first + 1) == todayDate) && (currentMonth == todayMonth) && (currentYear == todayYear)){
                    cell.setDayCell(firstDay: indexPath.row - first, textColor: 3)
                } else {
                    cell.setDayCell(firstDay: indexPath.row - first, textColor: 1)
                }
            }else {
                if (((indexPath.row - first + 1) == todayDate) && (currentMonth == todayMonth) && (currentYear == todayYear)){
                    print("currentYear", currentYear)
                    cell.setDayCell(firstDay: indexPath.row - first, textColor: 3)
                } else {
                    cell.setDayCell(firstDay: indexPath.row - first, textColor: 2)
                }
            }
            
        } else {
            //다음달~
            cell.setDayCell(firstDay: indexPath.row - last - first, textColor: 0)
        }
    
        
        if (indexPath.row - first + 1 == 12){
            cell.setEvent(eventName: eventTitle, color: eventColor)
        }
            
        
        return cell
    }


    
}
