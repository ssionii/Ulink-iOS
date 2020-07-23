//
//  TimeTableViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit


class TimeTableViewController: UIViewController, TimeTableDataSource, TimeTableDelegate, TimeTableListViewControllerDelegate, TimeTableSettingViewControllerDelegate,CreateTimeTableViewControllerDelegate, SubjectDetailViewControllerDelegate{
 
  
   
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var topDayView: UIView!
    @IBOutlet weak var timeTable: TimeTable!
    @IBOutlet weak var timeTableSemesterLabel: UILabel!
    
    private var timeTableInfo = TimeTableModel.init()
    private var subjectList : [SubjectModel] = []
    private var subjectDummyList : [SubjectModel] = []
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    private var isFirstOpen = true
    
    @IBOutlet weak var weekSpacing: NSLayoutConstraint!
    
    @IBAction func settingBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "timeTableSettingViewController") as? TimeTableSettingViewController else { return }
        
        nextVC.setTimeTableIdx(idx: timeTableInfo.scheduleIdx)
        nextVC.delegate = self
         self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func listBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "timeTableListViewController") as? TimeTableListViewController else { return }
        
        nextVC.delegate = self
        nextVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(nextVC, animated: false, completion: nil)
        
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name:"CreateTimeTable", bundle: nil)
        
        guard let nextVC = storyboard.instantiateViewController(identifier: "createTimeTableViewController") as? CreateTimeTableViewController else { return }
        
        nextVC.semester = timeTableInfo.semester
        nextVC.scheduleIdx = timeTableInfo.scheduleIdx
        nextVC.delegate = self
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSpacingForDevice()
        // Do any additional setup after loading the view.
        
        timeTable.delegate = self
        timeTable.dataSource = self
        
        setBackgroundView()
    }

    override func viewWillAppear(_ animated: Bool) {
        if isFirstOpen {
            getMainTimeTable()
            isFirstOpen = false
        }
    }

     override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setBackgroundView(){
        
        let gradientLayer = CAGradientLayer()
        
        //gradientLayer.frame = self.backgroundView.bounds
        gradientLayer.frame = self.view.bounds
        
        let colorLeft = UIColor(red: 127.0 / 255.0, green: 36.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0).cgColor
        let colorRight = UIColor(red: 95.0 / 255.0, green: 93.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0).cgColor
        

        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: -0.6, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.2)
        gradientLayer.locations = [0, 1]
        gradientLayer.shouldRasterize = true
        
        self.backgroundView.layer.addSublayer(gradientLayer)
        
    }
    
    func setSpacingForDevice()
    {
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height{
            
        case 450.0 ... 667.0 : // 6 6s 7 8
            
            self.weekSpacing.constant = 53
            
            break
            
        case 730.0 ... 810.0: // 6s+, 7+ 8+
            self.weekSpacing.constant = 53
            break
            
        case 812.0 ... 890.0: //X, XS
            
            //11pro
            self.weekSpacing.constant = 53
            
            break
        
        case 896.0:         // XS MAX
            //11
            self.weekSpacing.constant = 65
            break
           
        default:
            break
            
        }
        
    }
    
    // MARK:- protocol
    func timeTable(timeTable: TimeTable, selectedSubjectIdx : Int, isSubject : Bool) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "subjectDetailViewController") as? SubjectDetailViewController else { return }
        
        print(selectedSubjectIdx)
        
        nextVC.subjectIdx = selectedSubjectIdx
        nextVC.isSubject = isSubject
        nextVC.delegate = self
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
    
    func getTimeTable(idx: Int) {
           getTimeTableByIdx(idx: idx)
    }
    
    func updateMainView() {
        getTimeTableByIdx(idx: timeTableInfo.scheduleIdx)
    }
    
    func updateMainFromEnrollSubject() {
          getTimeTableByIdx(idx: timeTableInfo.scheduleIdx)
      }
    
    func updateSubjectDetail() {
        getTimeTable(idx: timeTableInfo.scheduleIdx)
     }
     
      
    
    
    // MARK:- 통신
    
    func getMainTimeTable(){
        
        print("getMainTimeTable")
       MainTimeTableService.shared.getMainTimeTable { networkResult in
            switch networkResult {
                case .success(let timeTable, let subjectList) :
                    self.timeTableInfo = timeTable as! TimeTableModel
                    self.subjectList = subjectList as! [SubjectModel]
                    self.timeTableSemesterLabel.text = (timeTable as! TimeTableModel).semesterText
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
    
    func getTimeTableByIdx(idx: Int){
        print("getTimeTable")
         
        TimeTableService.shared.getTimeTable(idx: idx) { networkResult in
             switch networkResult {
                 case .success(let timeTable, let subjectList) :
                    self.timeTableInfo = timeTable as! TimeTableModel
                     self.subjectList = subjectList as! [SubjectModel]
                    self.timeTableSemesterLabel.text = (timeTable as! TimeTableModel).semesterText
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

extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}
