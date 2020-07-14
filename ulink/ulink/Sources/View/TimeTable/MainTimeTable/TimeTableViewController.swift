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
    
    private var subjectList : [SubjectModel] = []
    private var subjectDummyList : [SubjectModel] = []
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        timeTable.delegate = self
        timeTable.dataSource = self
        
        setBackgroundView()
        getMainTimeTable()
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
        
        
    }
    
    
//    private func setSubjectList(){
//
//        for (_, subject) in subjectDummyList.enumerated() {
//            for i in 0 ... subject.day.count - 1 {
//                let start = subject.dateTime[i].split(separator: "-")[0]
//                let end = subject.dateTime[i].split(separator: "-")[1]
//
//                let subjectItem = SubjectModel(subjectName: subject.subjectName, roomName: subject.roomName, professorName: subject.professorName, subjectDay: subject.day[i], startTime: String(start), endTime: String(end), backgroundColor: subject.backgroundColor, day: subject.day, dateTime: subject.dateTime)
//
//                subjectList.append(subjectItem)
//            }
//        }
//    }
//
    private func makeDummySubjectList(){
        
        let dummy_1 = SubjectModel(subjectName: "영상처리", roomName: "제1공학관 404", professorName: "양시연", backgroundColor: 0, day: [1], dateTime: ["09:00-10:00"])
        let dummy_2 = SubjectModel(subjectName: "전자회로", roomName: "제1공학관 601", professorName: "양시연", backgroundColor: 1, day: [1], dateTime: ["13:00-15:00"])
        let dummy_3 = SubjectModel(subjectName: "전자기학", roomName: "제1공학관 303", professorName: "양시연", backgroundColor: 2, day: [2], dateTime: ["13:00-14:00"])
        let dummy_4 = SubjectModel(subjectName: "소설과 영화", roomName: "제2공학관 204", professorName: "양시연", backgroundColor: 3, day: [2], dateTime: ["14:00-16:30"])
        let dummy_5 = SubjectModel(subjectName: "캡스톤 디자인", roomName: "제2공학관 304", professorName: "양시연", backgroundColor: 4, day: [3], dateTime: ["10:00-13:00"])
        let dummy_6 = SubjectModel(subjectName: "모션그래픽스1", roomName: "미술대학 407실", professorName: "양시연", backgroundColor: 5, day: [3, 4], dateTime: ["13:00-15:30", "08:00-12:00"])
    
        subjectDummyList = [dummy_1, dummy_2, dummy_3, dummy_4, dummy_5, dummy_6]
        
        setSubjectList()
        
        
    }
    
    func timeTable(timeTable: TimeTable, didSelectSubject selectedSubject: SubjectModel) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "subjectDetailViewController") as? SubjectDetailViewController else { return }
        
        
        print(selectedSubject)
        
        nextVC.setDataForSubject(idx: 0, colorCode: selectedSubject.backgroundColor, name: selectedSubject.subjectName, day: selectedSubject.day, dateTime: selectedSubject.dateTime, room: selectedSubject.roomName, professor: selectedSubject.professorName)
        self.present(nextVC, animated: true, completion: nil)
        
    }
    
    func timeTableHintCount(hintCount: Int) {
    
    }

    func subjectItems(in timeTable: TimeTable) -> [SubjectModel] {
        return subjectList
    }

    func numberOfDays(in timeTable: TimeTable) -> Int {
        return self.daySymbol.count
    }

    func timeTable(timeTable: TimeTable, at dayPerIndex: Int) -> String {
        return self.daySymbol[dayPerIndex]
    }
    
    
    // 통신
    
    func getMainTimeTable(){
       TimeTableService.shared.getMainTimeTable { networkResult in
                      switch networkResult {
                          
                          
             // MARK:- 서버 접속 성공 했을때
                      case .success(let timeTable, let subjectList) :
                        self.subjectList = subjectList as! [SubjectModel]
                        print(subjectList)
                        self.timeTable.reloadData()
                        
                        break
                      case .requestErr(let message):
                          print("REQUEST ERROR")
//                          guard let message = message as? String else { return }
//                          let alertViewController = UIAlertController(title: "로그인 실패", message: message,
//                                                                      preferredStyle: .alert)
//                          let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
//                          alertViewController.addAction(action)
//                          self.present(alertViewController, animated: true, completion: nil)
                          break
                      case .pathErr: break
//                          let alertViewController = UIAlertController(title: "로그인 실패", message: "로그인 정보를 다시 확인해주세요",
//                                                                      preferredStyle: .alert)
//                          let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
//                          alertViewController.addAction(action)
//                          self.present(alertViewController, animated: true, completion: nil)
                      case .serverErr: print("serverErr")
                      case .networkFail: print("networkFail")
                      }
              }
    }
    
    

   
}
