//
//  AddSubjectByDragViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit


protocol AddSubjectByDragViewControllerDelegate {
    func didPressConfirmBtn()
}

class AddSubjectByDragViewController: UIViewController, TimeTableDelegate, TimeTableDataSource, AddSubjectDetailDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeTable: TimeTable!
    
    @IBOutlet weak var weekSpacing: NSLayoutConstraint!
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        timeTable.removeLastSchedule()
    }
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func confirmBtn(_ sender: Any) {
        
        if(confirmType == "추가"){
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "addSubjectDetailViewController") as? AddSubjectDetailViewController else { return }
                   
                   nextVC.setTimeInfo(list: timeTable.tempUserScheduleList)
                   nextVC.isFromDrag = true
                   nextVC.delegate = self
                   
                   self.present(nextVC, animated: true, completion: nil)
        }else {
            // 통신 personalList 보내기
            postPersonalSchedule()
            print("personalList", personalList)
            dismiss(animated: true, completion: nil)
        }

    }
    
    var delegate : AddSubjectByDragViewControllerDelegate?

    var timeTableInfo = TimeTableModel.init()
    var subjectList = [SubjectModel]()
    
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    public var scheduleIdx = 1
      
    private var confirmType = "확정"
    private var personalList = [PersonalScheduleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSpacingForDevice()
        
        setBackgroundView()
        setTimeTableView()
        
        
        timeTable.delegate = self
        timeTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTimeTableByIdx(idx: scheduleIdx)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    func setSpacingForDevice(){
           
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
           
        switch height {
               
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
    
    private func setTimeTableView(){

        timeTable.defaultMaxHour = 23

        // 드래그 가능하도록 설정
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
            confirmButton.setImage(UIImage(named: "timetableaddDrag1BtnAdd"), for: UIControl.State.normal)
            confirmType = "추가"
        } else {
            // 확정 버튼
            confirmButton.setImage(UIImage(named: "timetableaddDrag1BtnConfirm"), for: UIControl.State.normal)
             confirmType = "확정"
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
    
    func didPressOkButton(timeInfoList: [SubjectModel], isFromDrag : Bool) {
        
        if isFromDrag {
        
        let colorCount = timeTable.getColorCount()
    
        for timeInfo in timeInfoList {
            var temp = timeInfo
            temp.backgroundColor = colorCount
            subjectList.append(temp)
            
        }
        timeTable.reDrawTimeTable()
        
         confirmButton.setImage(UIImage(named: "timetableaddDrag1BtnConfirm"), for: UIControl.State.normal)
        confirmType = "확정"
        
        // list에 추가
        for timeInfo in timeInfoList {
            let personalSchedule = PersonalScheduleModel.init(name: timeInfo.subjectName, startTime: timeInfo.startTime[0], endTime: timeInfo.endTime[0], day: timeInfo.subjectDay[0], content: timeInfo.content[0], color: colorCount, scheudleIdx: self.scheduleIdx)
            
             personalList.append(personalSchedule)
        }
        }
    }
    
    func didDeleteTimeInfo(num: Int) {
        timeTable.removeSchedule(num: num + 1)
    }
     
    // MARK: - 통신
    func postPersonalSchedule(){
        print("postPersonalSchedule")
            
        PersonalScheduleService.shared.postPersonalScheudule(personalScheudleList: self.personalList){ networkResult in
                switch networkResult {
                    case .success(_, _) :
                        print("개인 일정 추가 성공")
                        self.delegate?.didPressConfirmBtn()
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
        print("getTimeTable From Drag idx : \(idx)")
        TimeTableService.shared.getTimeTable(idx: idx) { networkResult in
             switch networkResult {
                 case .success(let timeTable, let subjectList) :
                    self.timeTableInfo = timeTable as! TimeTableModel
                     self.subjectList = subjectList as! [SubjectModel]
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
