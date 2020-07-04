//
//  TimeTableViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController, TimeTableDataSource, TimeTableDelegate{

    @IBOutlet weak var timeTableBackgroundView: UIView!
    @IBOutlet weak var timeTable: TimeTable!
    
    private var subjectList : [Subject] = []
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        timeTable.delegate = self
        timeTable.dataSource = self
        
        setTimeTableBg()
        setSubjectList()
        
    }

    private func setSubjectList(){
        let subject_1 = Subject(subjectName: "모션 그래픽스 1", roomName: "미술대학 407실", subjectDay: .tuesday, startTime: "14:00", endTime: "16:15", backgroundColor: UIColor.darkGray)

        subjectList = [subject_1]
    }
    
    private func setTimeTableBg(){
        timeTableBackgroundView.layer.cornerRadius = 30
    }
    
    
    func timeTable(timeTable: TimeTable, didSelectSubject selectedSubject: Subject) {
        return
    }


    func subjectItems(in timeTable: TimeTable) -> [Subject] {
        return subjectList
    }

    func numberOfDays(in timeTable: TimeTable) -> Int {
        return self.daySymbol.count
    }

    func timeTable(timeTable: TimeTable, at dayPerIndex: Int) -> String {
        return self.daySymbol[dayPerIndex]
    }

   
}
