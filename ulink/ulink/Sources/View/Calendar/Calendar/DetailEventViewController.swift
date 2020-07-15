//
//  DetailEventViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/06.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class DetailEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailEventTableView: UITableView!
    
    var dummydummyData: [Event] = []
    var dummyData: [EventList] = []
    
    var numOfDetailCells: Int?
    var currentYear: Int?
    var currentMonth: Int?
    var currentDate: Int?
    var currentWeekDay: Int?
    
    var noticeList: [NoticeData]?
    
    //오늘 날짜 데이터
    let cal = Calendar(identifier: .gregorian)
    let today = Date()
    var todayMonth = Calendar.current.component(.month, from: Date())
    var todayYear = Calendar.current.component(.year, from: Date())
    var todayDate = Calendar.current.component(.day, from: Date())
    
    //더미데이터입니다룰루루얼쟈ㅓㅇㅍㅊ
    let eventName = ["영상처리 과제", "이름을 되게 길게 만들어볼까요 더더더더더더더", "소프트웨어개론 퀴즈"]
    let category = [2, 1, 0]
    let time = ["", "", "11:00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorView = UIView()
               colorView.backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectedBackgroundView = colorView
        
        //더미더ㅣㅁ
        dummydummyData = [Event(name: "소프트웨어공학", color: 1, notice_idx: 1, category: "시험", start_time: "9:00", end_time: "11:45", title: "중간고사"), Event(name: "창의적사고", color: 2, notice_idx: 1, category: "과제", start_time: "00:00", end_time: "23:59", title: "레포트 제출"), Event(name: "게임공학론", color: 1, notice_idx: 1, category: "수업", start_time: "9:00", end_time: "11:00", title: "휴강"), Event(name: "게임공학론", color: 1, notice_idx: 1, category: "수업", start_time: "9:00", end_time: "11:00", title: "휴강"), Event(name: "게임공학론", color: 1, notice_idx: 1, category: "수업", start_time: "9:00", end_time: "11:00", title: "휴강"), Event(name: "소프트웨어공학", color: 1, notice_idx: 1, category: "시험", start_time: "9:00", end_time: "11:45", title: "중간고사")]
        
        dummyData = [EventList(date: "2020-07-11", event: dummydummyData), EventList(date: "2020-07-11", event: dummydummyData), EventList(date: "2020-07-13", event: dummydummyData), EventList(date: "2020-08-29", event: dummydummyData)]
        
        popUpView.layer.cornerRadius = 20
        
        detailEventTableView.delegate = self
        detailEventTableView.dataSource = self
        
        getMonthlyData()
        setDateLabel()
        setupGestureRecognizer()
        
        if noticeList == nil {
            print(noticeList)
            let explainLabel =
                UILabel(frame: CGRect(x: 0, y: 0 + popUpView.frame.height / 3, width:popUpView.frame.width, height: 20))
            //explainLabel.center = CGPoint(x: popUpView.center.x, y: popUpView.center.y)
            explainLabel.text = "일정이 없습니다."
            explainLabel.textColor = UIColor.gray
            explainLabel.textAlignment = .center
            self.popUpView.addSubview(explainLabel)
        }
    }
    
    func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ tap: UIGestureRecognizer) {
        self.dismiss(animated: false)
    }
    
    func getMonthlyData(){
        guard let numOfDetailCells = self.numOfDetailCells else {return}
        guard let currentYear = self.currentYear else {return}
        guard let currentMonth = self.currentMonth else {return}
        guard let currentDate = self.currentDate else {return}
        guard let currentWeekDay = self.currentWeekDay else {return}
        guard let noticeList = self.noticeList else {return}
    }
    
    func setDateLabel(){
        let weekday = changeWeekdayToString(weekday: currentWeekDay!)
        var date = String(currentMonth!) + "월 " + String(currentDate!) + "일 "
        date.insert(contentsOf: weekday, at: date.endIndex)
        dateLabel.text = date
    }
    
    func changeWeekdayToString(weekday: Int) -> String{
        var stringWeekday: String
        switch weekday {
        case 1:
            stringWeekday = "일"
        case 2:
            stringWeekday = "월"
        case 3:
            stringWeekday = "화"
        case 4:
            stringWeekday = "수"
        case 5:
            stringWeekday = "목"
        case 6:
            stringWeekday = "금"
        case 7:
            stringWeekday = "토"
        default:
            stringWeekday = ""
        }

        //var dateString = String(currentMonth?) + "월 " + String(currentDate?) + "일 "
        return stringWeekday
    }
    
    // MARK: tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
        return UITableViewCell() }
        //cell.set(dummyData[indexPath.section].event[indexPath.row])
        if let notice = noticeList?[indexPath.row]{
            cell.set(notice)
        }
        cell.changeViewColor(dummyData[indexPath.section].date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return detailEventTableView.frame.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Chatting", bundle: nil)
        
        guard let popUpVC = sb.instantiateViewController(identifier: "NoticeEditViewController") as? NoticeEditViewController else {return}
        
        if (noticeList?[indexPath.row].category == "과제") {
            popUpVC.cateogoryIdx = 1
        } else if (noticeList?[indexPath.row].category == "시험"){
            popUpVC.cateogoryIdx = 2
        } else {
            popUpVC.cateogoryIdx = 3
        }
        
        popUpVC.noticeIdx = noticeList?[indexPath.row].noticeIdx as! Int
        
        popUpVC.modalPresentationStyle = .overCurrentContext
        present(popUpVC, animated: true, completion: nil)
        
    }
}

extension DetailEventViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view?.isDescendant(of: popUpView) ?? false)
    }
}
