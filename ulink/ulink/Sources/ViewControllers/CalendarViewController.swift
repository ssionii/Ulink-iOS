//
//  CalendarViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var myCalendar: FSCalendar!

    var dates: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        //요일 label 한글로 변경
        myCalendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        myCalendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        myCalendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        myCalendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        myCalendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        myCalendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        myCalendar.calendarWeekdayView.weekdayLabels[6].text = "토"
    }
    
}
