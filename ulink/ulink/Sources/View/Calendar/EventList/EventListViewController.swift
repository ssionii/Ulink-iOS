//
//  EventListViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventListTableView: UITableView!
    @IBOutlet weak var lineView: UIView!
    
    var dummydummyData: [Event] = []
    var dummyData: [EventList] = []
    
    //오늘 날짜 데이터
    let cal = Calendar(identifier: .gregorian)
    let today = Date()
    var todayMonth = Calendar.current.component(.month, from: Date())
    var todayYear = Calendar.current.component(.year, from: Date())
    var todayDate = Calendar.current.component(.day, from: Date())
    
    let dateLabel = UILabel(frame : CGRect(x: 10, y: 10, width: 0, height: 0))
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: 44))
    
    var serverData: [SecondData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        disableStickyHeader()
        lineView.backgroundColor = UIColor.whiteThree
        //cellColorView.layer.cornerRadius = 19
    
        getDataFromServer()
        
        //더미더ㅣㅁ
        dummydummyData = [Event(name: "소프트웨어공학", color: 1, notice_idx: 1, category: "시험", start_time: "9:00", end_time: "11:45", title: "중간고사"), Event(name: "창의적사고", color: 2, notice_idx: 1, category: "과제", start_time: "00:00", end_time: "23:59", title: "레포트 제출"), Event(name: "게임공학론", color: 1, notice_idx: 1, category: "수업", start_time: "9:00", end_time: "11:00", title: "휴강")]
        
        dummyData = [EventList(date: "2020-07-09", event: dummydummyData), EventList(date: "2020-07-11", event: dummydummyData), EventList(date: "2020-07-13", event: dummydummyData), EventList(date: "2020-08-29", event: dummydummyData)]
        
        eventListTableView.dataSource = self
        eventListTableView.delegate = self
    }
    
    // MARK: SERVER 통신
    func getDataFromServer(){
        
        var startQuery = String(todayYear) + "-" + String(todayMonth) + "-" + String(todayDate)
        
        let tenDaysLater = Calendar.current.date(byAdding: .day, value: 30, to: today) ?? today
        
        var endYear = Calendar.current.component(.year, from: tenDaysLater)
        var endMonth = Calendar.current.component(.month, from: tenDaysLater)
        var endDate = Calendar.current.component(.day, from: tenDaysLater)
        
        var endQuery = String(endYear) + "-" + String(endMonth) + "-" + String(endDate)
        
        print(startQuery, "-", endQuery)
        
        CalendarService.shared.openCalendarData(start: startQuery, end: endQuery){
                    networkResult in
                    switch networkResult {
                    case .success(let tokenData):
                        guard let token = tokenData as? [SecondData] else {return}
                        self.serverData = token
                        self.eventListTableView.reloadData()
                    case .requestErr:
                        print("requestErr")
                    case .pathErr:
                        print("pathErr")
                    case .serverErr:
                        print("serverErr")
                    case .networkFail:
                        print("networkFail")
                    }
        }
    }
    
    
    func disableStickyHeader(){
        let dummyViewHeight = CGFloat(40)
        self.eventListTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.eventListTableView.bounds.size.width, height: dummyViewHeight))
        self.eventListTableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
    }

    @IBAction func backToCalendar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 테이블뷰
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverData?[section].notice?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
        return UITableViewCell() }
        
        if let serverData = serverData?[indexPath.section].notice?[indexPath.row] {
            cell.set(serverData)
        }
        cell.changeViewColor(serverData?[indexPath.section].date ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListHeaderCell.identifier) as? EventListHeaderCell else {
        return UITableViewCell() }
        
        if let serverData = serverData?[section] {
            cell.set(serverData)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return serverData?.count ?? 0
    }

}
