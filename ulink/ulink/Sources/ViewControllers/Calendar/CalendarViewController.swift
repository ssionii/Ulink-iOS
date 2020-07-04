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
    
    
    var monthLabels = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    var numOfDate = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    //오늘 날짜 데이터
    let cal = Calendar(identifier: .gregorian)
    let today = Date()
    var todayMonth = Calendar.current.component(.month, from: Date())
    var todayYear = Calendar.current.component(.year, from: Date())
    var todayDate = Calendar.current.component(.day, from: Date())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthLabel.text = String(todayMonth) + "월"
        
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
        let dateString = "01-" + String(todayMonth) + "-" + String(todayYear)
        let myDay = dateFormatter.date(from: dateString)
        let first = cal.dateComponents([.weekday], from: myDay!)
        
        let firstWeekDay = first.weekday!
        print("firstweekday", firstWeekDay)
        return firstWeekDay
    }
    
    func getLastDay() -> Int{
        
        var last: Int
        
        if (todayMonth == 0){
            last = numOfDate[11]
        } else if (todayMonth == 1){
            last = numOfDate[todayMonth - 1]
        } else {
            last = numOfDate[todayMonth - 1]
        }
        
        return last
    }
    
    func getLastOfLastDay() -> Int {
        var lastOfLast: Int
        
        if (todayMonth == 0){
            lastOfLast = numOfDate[10]
        } else if (todayMonth == 1){
            lastOfLast = numOfDate[11]
        } else {
            lastOfLast = numOfDate[todayMonth - 2]
        }
        
        return lastOfLast
    }
    
    @IBAction func clickNextBtn(_ sender: Any) {
        
        if (todayMonth == 12) {
            todayMonth = 1
            todayYear += 1
            
            if (todayYear % 4 == 0){
                numOfDate[1] = 29
            } else {
                numOfDate[1] = 28
            }
            
        } else {
            todayMonth += 1
        }
        
        monthLabel.text = String(todayMonth) + "월"
        calendarCollectionView.reloadData()
    }
    
    @IBAction func clickPrevBtn(_ sender: Any) {
        if (todayMonth == 1) {
            todayMonth = 12
            todayYear -= 1
            
            if (todayYear % 4 == 0){
                numOfDate[1] = 29
            } else {
                numOfDate[1] = 28
            }
            
        } else {
            todayMonth -= 1
        }
        
        monthLabel.text = String(todayMonth) + "월"
        calendarCollectionView.reloadData()
    }
    
    //collectionview layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 8)/7, height: collectionView.frame.height/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
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
                cell.setDayCell(firstDay: indexPath.row - first, textColor: 1)
            } else {
                cell.setDayCell(firstDay: indexPath.row - first, textColor: 2)
            }
        } else {
            //다음달~
            cell.setDayCell(firstDay: indexPath.row - last - first, textColor: 0)
        }
        
        
        return cell
    }


    
}
