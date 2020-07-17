//
//  TimeTableSettingViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol TimeTableSettingViewControllerDelegate {
    func updateMainView()
}

class TimeTableSettingViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var botLayout: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
        
    private let viewHeight: CGFloat = 300
    private let hideBotViewHeight : CGFloat = 223
    private let isDismiss = false
    
    @IBOutlet weak var setMainTimeTableView: UIView!
    @IBOutlet weak var changeStyleView: UIView!
    @IBOutlet weak var saveImageView: UIView!
    @IBOutlet weak var moveToTrashView: UIView!
    
    var timeTableIdx = 0
    var delegate : TimeTableSettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setViewTap()
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        isDismiss ? disAppearAnim() : appearAnim()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != backgroundView {
           return
        }
    
         disAppearAnim()
    }
    
    public func setTimeTableIdx(idx: Int){
        timeTableIdx = idx
    }
    
    private func setViewTap(){
        print(timeTableIdx)
        setMainTimeTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setMainTimeTable)))
        
        changeStyleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editName)))
        
        saveImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveImage)))
        
        moveToTrashView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToTrash)))
        
    }
    
    func appearAnim(){
        self.botLayout.constant = hideBotViewHeight - viewHeight
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }

    func disAppearAnim(){
        self.botLayout.constant = -self.viewHeight
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
        
        dismiss(animated: true)
    }
    
    private func alert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                   let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                    self.disAppearAnim()
                   })
        
                   alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func setMainTimeTable(sender:UIGestureRecognizer){
               print(timeTableIdx)
        self.updateMainTimeTable()
               print(timeTableIdx)
    }
    
    @objc func editName(sender:UIGestureRecognizer){
        
        let alertController = UIAlertController(title: "시간표 이름을 입력해 주세요.", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                self.editTimeTableName(name: text)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (_) in
            self.disAppearAnim()
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "시간표 이름"
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func saveImage(sender:UIGestureRecognizer){
        print("이미지로 저장")
    }
    
    @objc func moveToTrash(sender:UIGestureRecognizer){
        print("시간표 삭제")
    }
    
    
    func updateMainTimeTable(){
           print("updateTimeTable")
        MainTimeTableService.shared.updateMainTimeTable(idx: self.timeTableIdx){ networkResult in
                switch networkResult {
                    case .success(_, _) :
                        self.alert(message: "대표 시간표가 변경되었습니다.")
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
    
    func editTimeTableName(name: String){
        print("editTimeTableName")
        TimeTableSettingService.shared.editTimeTableName(idx: self.timeTableIdx, name: name){ networkResult in
                   switch networkResult {
                       case .success(_, _) :
                        print("시간표 이름 변경 성공")
                        self.delegate?.updateMainView()
                           break
                       case .requestErr(let message):
                               print("REQUEST ERROR")
                               break
                       case .pathErr: break
                       case .serverErr: print("serverErr")
                       case .networkFail: print("networkFail")
                   }
            self.disAppearAnim()
               }
          }
       
}
