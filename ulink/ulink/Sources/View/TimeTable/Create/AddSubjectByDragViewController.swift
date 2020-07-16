//
//  AddSubjectByDragViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit


class AddSubjectByDragViewController: UIViewController, TimeTableDelegate, TimeTableDataSource, AddSubjectDetailDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeTable: TimeTable!
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        timeTable.removeLastSchedule()
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "addSubjectDetailViewController") as? AddSubjectDetailViewController else { return }
        
        nextVC.setTimeInfo(list: timeTable.tempUserScheduleList)
        nextVC.isFromDrag = true
        nextVC.delegate = self
        
        self.present(nextVC, animated: true, completion: nil)
    
    }
    
    
    var subjectList : [SubjectModel] = []
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundView()
        setTimeTableView()
        
        timeTable.delegate = self
        timeTable.dataSource = self
   
      
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setTimeTableView(){

        timeTable.widthOfTimeAxis = 20
        timeTable.defaultMaxHour = 20

        timeTable.controller.setDrag()
        
    }
    
    private func setBackgroundView(){
        
        let gradientLayer = CAGradientLayer()
              
        gradientLayer.frame = self.backgroundView.bounds
              
        let colorLeft = UIColor(red: 127.0 / 255.0, green: 36.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0).cgColor
        let colorRight = UIColor(red: 95.0 / 255.0, green: 93.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0).cgColor
          
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: -0.6, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.2)
        gradientLayer.locations = [0, 1]
        gradientLayer.shouldRasterize = true
              
        self.backgroundView.layer.addSublayer(gradientLayer)
    }

    // protocol
     func timeTable(timeTable: TimeTable, selectedSubjectIdx: Int, isSubject : Bool){
           
       }
    
    func timeTableHintCount(hintCount: Int) {
        if hintCount > 0 {
            // 추가 버튼
            print("추가")
        } else {
            // 확정 버튼
            print("확정")
        }
    }
       
    func timeTable(timeTable: TimeTable, at dayPerIndex: Int) -> String {
        return daySymbol[dayPerIndex]
    }
       
    func numberOfDays(in timeTable: TimeTable) -> Int {
        return daySymbol.count
    }
       
    func subjectItems(in timeTable: TimeTable) -> [SubjectModel] {
        return subjectList
    }
    
    func didPressOkButton(timeInfoList: [SubjectModel]) {
        
        let colorCount = timeTable.getColorCount()
        for i in 0 ... timeInfoList.count - 1 {
            var temp = timeInfoList[i]
            temp.backgroundColor = colorCount
            subjectList.append(temp)
            
        }
        timeTable.reDrawTimeTable()
        
       print("확정")
    }
    
    func didDeleteTimeInfo(num: Int) {
        timeTable.removeSchedule(num: num + 1)
    }
       

}
