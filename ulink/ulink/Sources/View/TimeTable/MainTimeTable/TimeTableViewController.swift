//
//  TimeTableViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController, TimeTableDataSource, TimeTableDelegate{

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var topDayView: UIView!
    @IBOutlet weak var timeTable: TimeTable!
    
    @IBAction func settingBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "timeTableSettingViewController") as? TimeTableSettingViewController else { return }
        
        nextVC.modalPresentationStyle = .fullScreen
         self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func listBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "timeTableListViewController") as? TimeTableListViewController else { return }
        
        nextVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(nextVC, animated: false, completion: nil)
        
    }
    
    
    private var subjectList : [Subject] = []
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        timeTable.delegate = self
        timeTable.dataSource = self
        
        setBackgroundView()
        setSubjectList()
    }

     override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
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

    private func setSubjectList(){
        let subject_1 = Subject(subjectName: "영상처리", roomName: "제1공학관 404", subjectDay: .monday, startTime: "09:00", endTime: "10:00", backgroundColor: 0)
        let subject_2 = Subject(subjectName: "전자회로", roomName: "제1공학관 601", subjectDay: .monday, startTime: "13:00", endTime: "15:00", backgroundColor: 1)
        let subject_3 = Subject(subjectName: "전자기학", roomName: "제1공학관 303", subjectDay: .tuesday, startTime: "13:00", endTime: "14:00", backgroundColor: 2)
        let subject_4 = Subject(subjectName: "소설과 영화", roomName: "제2공학관 204", subjectDay: .tuesday, startTime: "14:00", endTime: "16:30", backgroundColor: 3)
        let subject_5 = Subject(subjectName: "캡스톤 디자인", roomName: "제2공학관 304", subjectDay: .wendsday, startTime: "10:00", endTime: "13:00", backgroundColor: 4)
        let subject_6 = Subject(subjectName: "모션그래픽스1", roomName: "미술대학 407실", subjectDay: .wendsday, startTime: "13:00", endTime: "15:30", backgroundColor: 5)
        let subject_7 = Subject(subjectName: "모션그래픽스1", roomName: "미술대학 407실", subjectDay: .thursday, startTime: "08:00", endTime: "12:00", backgroundColor: 5)
        
        
        subjectList = [subject_1, subject_2, subject_3, subject_4, subject_5, subject_6, subject_7]
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
