//
//  EventListViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/09.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dum = Event.init(name: "오버워치", color: 1, notice_idx: 1, category: "과제", start_time: "15:00", end_time: "14:00", title: "하고싶다")
    
    
   
    

    
    
    var whichCell: [Int] = []

    @IBOutlet weak var eventListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummydummyData = [Event(name: "소프트웨어공학", color: 1, notice_idx: 1, category: "시험", start_time: "9:00", end_time: "11:45", title: "중간고사"), Event(name: "창의적사고", color: 2, notice_idx: 1, category: "과제", start_time: "00:00", end_time: "23:59", title: "레포트 제출"), Event(name: "게임공학론", color: 1, notice_idx: 1, category: "수업", start_time: "9:00", end_time: "11:00", title: "휴강")]
        
        let dummyData = [EventList(date: "2020-07-09", event: dummydummyData), EventList(date: "2020-07-11", event: dummydummyData), EventList(date: "2020-07-14", event: dummydummyData)]
        
        for i in 0...dummyData.count-1{
            whichCell.append(1)
            for _ in 0...dummyData[i].event.count-1{
                whichCell.append(0)
            }
        }

        eventListTableView.delegate = self
        eventListTableView.dataSource = self
    }

    @IBAction func backToCalendar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whichCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentCell = tableView.dequeueReusableCell(withIdentifier: EventContentCell.identifier, for: indexPath) as? EventContentCell else {
        return UITableViewCell() }
        
        guard let titleCell = tableView.dequeueReusableCell(withIdentifier: EventTitleCell.identifier, for: indexPath) as? EventTitleCell else {
        return UITableViewCell() }
        
        if (whichCell[indexPath.row] == 0){
            return contentCell
        } else {
            return titleCell
        }
    }

}
