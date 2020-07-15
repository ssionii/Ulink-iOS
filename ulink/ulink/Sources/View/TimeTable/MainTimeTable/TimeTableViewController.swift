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
    
    func timeTable(timeTable: TimeTable, selectedSubjectIdx : Int, isSubject : Bool) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "subjectDetailViewController") as? SubjectDetailViewController else { return }
        
        print(selectedSubjectIdx)
        
        nextVC.subjectIdx = selectedSubjectIdx
        nextVC.isSubject = isSubject
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
        
        print("getMainTimeTable")
        
       MainTimeTableService.shared.getMainTimeTable { networkResult in
            switch networkResult {
                case .success(let timeTable, let subjectList) :
                    self.subjectList = subjectList as! [SubjectModel]
                    print(subjectList)
                    self.timeTable.reloadData()
                    break
                case .requestErr(let message):
                        print("REQUEST ERROR")
                        break
            case .pathErr: break
            case .serverErr: print("serverErr")
                case .networkFail: print("networkFail")
            }
        }
    }

}
