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
    
    //월별 1일의 요일 받기
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthLabel.text = String(todayMonth) + "월"
        
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
        
        return firstWeekDay
    }
    
    //collectionview layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/10, height: collectionView.frame.height/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    //collectionview cell 띄우기
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.identifier, for: indexPath) as? DayCell else {
        return UICollectionViewCell() }
        
        let first = getFirstWeekDay() - 1
        let last = numOfDate[todayMonth - 1]
        
        if (indexPath.row >= 0 && indexPath.row < first){
            //저번달~
            cell.setDayCell(firstDay: numOfDate[todayMonth - 2] - first + indexPath.row)
        } else if (indexPath.row >= first && indexPath.row < last + first){
            //이번달~
            cell.setDayCell(firstDay: indexPath.row - first)
        } else {
            //다음달~
        }
        
        
        return cell
    }


    
}
