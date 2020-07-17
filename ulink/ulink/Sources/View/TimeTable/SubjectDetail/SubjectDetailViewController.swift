//
//  SubjectDetailViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit


class SubjectDetailViewController: UIViewController {
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var detailBackgroundView: UIView!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var subjectTimeInfoLabel: UILabel!
    @IBOutlet weak var subjectMemoInfoLabel: UILabel!
    
    
    @IBOutlet weak var goChatViewHeight: NSLayoutConstraint!
    @IBOutlet weak var goChatImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var goChatLabelHeight: UILabel!
    
    @IBOutlet weak var noticeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var noticeImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var editNameViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var editNameImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var editNameLabel: UILabel!
    
    @IBOutlet weak var customizingView: UIView!
    @IBOutlet weak var deleteView: UIView!
    
    
    private let defaultViewHeight = CGFloat(37.0)
    
    private var subjectColorCode = 0
    private var subjectName = ""
    private var subjectTimeInfo = ""
    private var subjectMemo = ""
    
    public var subjectIdx = 0
    public var isSubject = true

    private func makeToTimeInfoFormat(day : [Int], dateTime : [String]) -> String {
           
        var result = ""
           
           for i in 0 ... day.count - 1 {
               switch day[i] {
               case 0:
                   result += "월 "
                   break
               case 1:
                   result += "화 "
                   break
               case 2:
                   result += "수 "
                   break
               case 3:
                   result += "목 "
                   break
               case 4:
                   result += "금 "
                   break
               case 5:
                   result += "토 "
                   break
               default:
                   result += "월 "
                   break
               }
               
               result += dateTime[i].split(separator: "-")[0]
               result += " - "
               result += dateTime[i].split(separator: "-")[1]
               
               if i != day.count - 1 {
                   result += ", "
               }
           }
           
        return result
           
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailBackgroundView.layer.cornerRadius = 30
        colorView.layer.cornerRadius = 8
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isSubject {
            editNameViewHeight.constant = 0
            editNameLabel.text = ""
            editNameImageViewHeight.constant = 0
        } else {
            goChatViewHeight.constant = 0
            goChatImageViewHeight.constant = 0
            goChatLabelHeight.text = ""
            
            noticeViewHeight.constant = 0
            noticeImageViewHeight.constant = 0
            noticeLabel.text = ""
        }
        
        // 통신
        getSubjectDetail()
        
        putGesture()
        
    }
    
    

    
    
    private func setLabels(){
        colorView.backgroundColor = ColorPicker.init().getColor(subjectColorCode).color
        subjectNameLabel.text = subjectName
        subjectTimeInfoLabel.text = subjectTimeInfo
        subjectMemoInfoLabel.text = subjectMemo
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != backgroundView {
           return
        }
    
         dismiss(animated: true, completion: nil)
    }
    
    private func makeTimeInfo(day : [Int], startTime : [String], endTime : [String]) -> String {
        
        var result = ""
        
        for (index, d) in day.enumerated() {
            switch d {
            case 0:
                result += "월 "
                break
            case 1:
                result += "화 "
                break
            case 2:
                result += "수 "
                break
            case 3:
                result += "목 "
                break
            case 4:
                result += "금 "
                break
            default:
                result += "월 "
            }
            
            result += startTime[index] + " - " + endTime[index]
            
            if index < day.count - 1 {
                result += ", "
            }
        }
        
        return result
        
    }
    
    private func makeMemo(content: [String], professor : String) -> String{
        var result = ""
        for (index, c) in content.enumerated() {
            result += c
            
            if index < content.count - 1 {
                result += ", "
            }
        }
        
        if isSubject {
            result += ", " + professor + " 교수"
        }
        
        return result
    }
    
    private func getSubjectDetail(){
        
        print("getSubjectDetail")
        
        SubjectDetailService.shared.getMainTimeTable(idx: subjectIdx, isSubject: isSubject) { networkResult in
            
            print(networkResult)
            switch networkResult {
                case .success(let detail, _) :
                    print("success")
                    
                    let subjectDetail = detail as! SubjectModel
                
                    self.subjectColorCode = subjectDetail.backgroundColor
                    self.subjectName = subjectDetail.subjectName
                    self.subjectTimeInfo = self.makeTimeInfo(day: subjectDetail.subjectDay, startTime: subjectDetail.startTime, endTime: subjectDetail.endTime)
                    self.subjectMemo = self.makeMemo(content: subjectDetail.content, professor: subjectDetail.professorName)
                    
                    print(subjectDetail)
                    self.setLabels()
                
                    

                    break
                case .requestErr(let message):
                        print("REQUEST ERROR")
                        break
            case .pathErr:  print("pathErr"); break
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
    }
    
    //성은 추가
    private func putGesture(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.showCustomizing))
        
        self.customizingView.addGestureRecognizer(gesture)
        self.deleteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDeleteSubjectAlert)))
    }
    
    @objc func showCustomizing(sender : UITapGestureRecognizer) {
        guard let presenting = self.presentingViewController else {return}
        
        let popStoryBoard = UIStoryboard(name: "ColorPick", bundle: nil)
        let presentVC = popStoryBoard.instantiateViewController(withIdentifier: "colorPickVC")
        presentVC.modalPresentationStyle = .overCurrentContext
        
        //subjectName
        
        self.dismiss(animated: true){
            presenting.present(presentVC, animated: true, completion: nil)
        }
    }
    
    @objc func showDeleteSubjectAlert(sender : UITapGestureRecognizer) {
          
        let alert = UIAlertController(title: "", message: "일정을 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)

              alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: { (_) in
                  
                  // todo 통신
                self.deleteSubject(idx: self.subjectIdx)
              }))
        
        alert.addAction(UIAlertAction(title: "취소",style: UIAlertAction.Style.destructive, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK:- 통신
    
    func deleteSubject(idx: Int){
        
        print("deleteSubject")
        SubjectDetailService.shared.deleteSchoolSubject(idx: idx) { networkResult in
            switch networkResult {
                case .success(_, _) :
                    let alert = UIAlertController(title: "", message: "삭제가 완료되었습니다.", preferredStyle: UIAlertController.Style.alert)

                        alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: { (_) in
                             self.dismiss(animated: true, completion: nil)
                        }))
                                     
                       
                        self.present(alert, animated: true, completion: nil)
                    
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
