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
    @IBOutlet weak var todayBtn: UIButton!
    
    var numOfDate = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    //오늘 날짜 데이터
    let cal = Calendar(identifier: .gregorian)
    let today = Date()
    var todayMonth = Calendar.current.component(.month, from: Date())
    var currentMonth: Int = 0
    var todayYear = Calendar.current.component(.year, from: Date())
    var currentYear: Int = 0
    var todayDate = Calendar.current.component(.day, from: Date())
    
    let eventTitle = ["성은이개론", "맹구룩", "영상처리", "식생활문화"]
    let eventColor = [UIColor.powderPink, UIColor.lightblue, UIColor.periwinkleBlue, UIColor.pink]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //처음 열었을 시 오늘 날짜가 있는 달을 띄워주도록
        currentMonth = todayMonth
        currentYear = todayYear
        
        //view 설정
        calendarSubView.layer.cornerRadius = 30
        monthLabel.text = String(currentMonth) + "월"
        todayBtn.setTitle(String(todayDate), for: .normal)
        
        //윤년 설정
        if (todayYear % 4 == 0){
            numOfDate[1] = 29
        } else {
            numOfDate[1] = 28
        }
        
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        
    }
    
    //1일이 무슨 요일인지
    func getFirstWeekDay() -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let dateString = "01-" + String(currentMonth) + "-" + String(currentYear)
        let myDay = dateFormatter.date(from: dateString)
        let first = cal.dateComponents([.weekday], from: myDay!)
        
        let firstWeekDay = first.weekday!
        return firstWeekDay
    }
    
    //요일 구하기
    func getWeekDay(date: Int, month: Int, year: Int) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let dateString = String(date) + "-" + String(month) + "-" + String(year)
        let myDay = dateFormatter.date(from: dateString)
        let first = cal.dateComponents([.weekday], from: myDay!)
        
        let firstWeekDay = first.weekday!
        return firstWeekDay
    }
    
    //현재 달의 마지막 일
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
    
    //지난 달의 마지막 일
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
    @IBAction func swipeRight(_ sender: Any) {
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
    
    @IBAction func swipeLeft(_ sender: Any) {
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
    
    //오늘이 포함된 달로 돌아오기
    @IBAction func backToToday(_ sender: Any) {
        currentYear = todayYear
        currentMonth = todayMonth
        monthLabel.text = String(currentMonth) + "월"
        calendarCollectionView.reloadData()
    }
    
    @IBAction func showPopUp(_ sender: Any) {
        let popStoryBoard = UIStoryboard(name: "Calendar" , bundle: nil)
        let popUpVC = popStoryBoard.instantiateViewController(withIdentifier: "detailEvent")
        popUpVC.modalPresentationStyle = .overCurrentContext
        present(popUpVC, animated: true, completion: nil)
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
    
    // MARK: cell click event
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let first = getFirstWeekDay() - 1
        
        //let popStoryBoard = UIStoryboard(name: "Calendar" , bundle: nil)
        //let popUpVC = popStoryBoard.instantiateViewController(withIdentifier: "detailEvent")
        guard let popUpVC = self.storyboard?.instantiateViewController(identifier: "detailEvent") as? DetailEventViewController else {return}
        
        var passYear = currentYear
        var passMonth = currentMonth
        var passDate = todayDate
        var numOfDetailCells = 0
        
        //넘겨줄 데이타
        if (indexPath.row >= 0 && indexPath.row < first){
            //저번달~
            if (currentMonth == 1) {
                passMonth = 12
                passYear = currentYear - 1
                if ((passYear % 4 == 0)  && (passMonth == 1)){
                    numOfDetailCells = 29
                } else {
                    numOfDetailCells = numOfDate[currentMonth - 1]
                }
            } else {
                passMonth = currentMonth - 1
            }
            passDate = numOfDate[passMonth - 1] - first + indexPath.row + 1
        } else if (indexPath.row >= first && indexPath.row < getLastDay() + first){
            //이번달~
            passYear = currentYear
            passMonth = currentMonth
            passDate = indexPath.row - first + 1
        } else {
            //다음달~
            if (currentMonth == 12) {
                passMonth = 1
                passYear = currentYear + 1
            } else {
                passMonth = currentMonth + 1
            }
            passDate = indexPath.row - numOfDate[currentMonth - 1] - first + 1
        }
        var passWeekDay = getWeekDay(date: passDate, month: passMonth, year: passYear)
        
        popUpVC.currentYear = passYear
        popUpVC.currentMonth = passMonth
        popUpVC.currentDate = passDate
        popUpVC.numOfDetailCells = numOfDate[currentMonth-1]
        popUpVC.currentWeekDay = passWeekDay
        
        popUpVC.modalPresentationStyle = .overCurrentContext
        present(popUpVC, animated: false, completion: nil)
        
        print(indexPath.row - first + 1)
    }
    
    // MARK: collectionview layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 5.0)/7.0, height: 126)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    // MARK: collectionview cell 띄우기
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
                    cell.setDayCell(firstDay: indexPath.row - first, textColor: 3)
                } else {
                    cell.setDayCell(firstDay: indexPath.row - first, textColor: 2)
                }
            }
            
        } else {
            //다음달~
            cell.setDayCell(firstDay: indexPath.row - last - first, textColor: 0)
        }
    
        //이벤트 넣기
        if (indexPath.row - first + 1 == 12){
            cell.setEvent(eventName: eventTitle, color: eventColor)
        } else {
            cell.clearEvent()
        }
        
        return cell
    }

    
}



/*
 
 성은이의 통신을 위한 주석
 지난달 placeholder ~ 다음달 placeholder 까지의 데이터 request
 =>
 currentMonth - 1 월 lastOfLast - first + 1 일
 ~
 currentMonth + 1 월 7 - last의 요일 일
  
 last의 요일 : getWeekDay(lastoflast)
 
 */
