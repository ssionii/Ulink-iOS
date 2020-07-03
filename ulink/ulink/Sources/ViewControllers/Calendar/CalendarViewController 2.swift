//
//  CalendarViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var myCalendar: FSCalendar!

    let formatter = DateFormatter()
    var dates: Date!
    var events: [Date] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCalendar.dataSource = self
        myCalendar.delegate = self

        setCalendar()
    }
    
    
    @IBAction func clickNextBtn(_ sender: Any) {
        myCalendar.setCurrentPage(getNextMonth(date: myCalendar.currentPage), animated: true)
    }
    
    @IBAction func clickPrevBtn(_ sender: Any) {
        myCalendar.setCurrentPage(getPrevMonth(date: myCalendar.currentPage), animated: true)
    }
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPrevMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    func setCalendar(){
        myCalendar.appearance.headerDateFormat = "M 월"
        myCalendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        myCalendar.appearance.todayColor = UIColor.purple
        myCalendar.appearance.borderRadius = 0.3
        
        //요일 label 한글로 변경
        myCalendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        myCalendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        myCalendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        myCalendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        myCalendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        myCalendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        myCalendar.calendarWeekdayView.weekdayLabels[6].text = "토"
    }
    
    func addEvent(){
        
        print("addEvent호출")
        
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
              
        let xmas = formatter.date(from: "2020-07-01")
        let sampledate = formatter.date(from: "2020-07-02")
        
        print(xmas!)
        
        events = [xmas!, sampledate!]
        
        print("events", events)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        addEvent()
        if self.events.contains(date){
            return 1
        }
        return 0
    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        print("이미지")
//        return UIImage(named: "로고")
//    }
    
}
