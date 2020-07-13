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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        disableStickyHeader()
        lineView.backgroundColor = UIColor.whiteThree
        //cellColorView.layer.cornerRadius = 19
    
        //더미더ㅣㅁ
        dummydummyData = [Event(name: "소프트웨어공학", color: 1, notice_idx: 1, category: "시험", start_time: "9:00", end_time: "11:45", title: "중간고사"), Event(name: "창의적사고", color: 2, notice_idx: 1, category: "과제", start_time: "00:00", end_time: "23:59", title: "레포트 제출"), Event(name: "게임공학론", color: 1, notice_idx: 1, category: "수업", start_time: "9:00", end_time: "11:00", title: "휴강")]
        
        dummyData = [EventList(date: "2020-07-11", event: dummydummyData), EventList(date: "2020-07-11", event: dummydummyData), EventList(date: "2020-07-13", event: dummydummyData), EventList(date: "2020-08-29", event: dummydummyData)]
        
        eventListTableView.dataSource = self
        eventListTableView.delegate = self
    }
    
    
    
    func disableStickyHeader(){
        let dummyViewHeight = CGFloat(40)
        self.eventListTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.eventListTableView.bounds.size.width, height: dummyViewHeight))
        self.eventListTableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
    }

    @IBAction func backToCalendar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData[section].event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
        return UITableViewCell() }
        
        cell.set(dummyData[indexPath.section].event[indexPath.row])
        cell.changeViewColor(dummyData[indexPath.section].date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListHeaderCell.identifier) as? EventListHeaderCell else {
        return UITableViewCell() }
        
        //셀 클릭 색ㄱ깔 없애기
        let colorView = UIView()
        colorView.backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectedBackgroundView = colorView
        
        cell.set(dummyData[section])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dummyData.count
    }

}
