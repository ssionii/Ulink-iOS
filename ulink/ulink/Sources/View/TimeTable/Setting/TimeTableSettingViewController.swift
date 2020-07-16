//
//  TimeTableSettingViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("timeTableIdx at ViewDidLoad", timeTableIdx)
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
        print("setTImeTableIdx")
        timeTableIdx = idx
        print("timeTalbl", timeTableIdx)
    }
    
    private func setViewTap(){
        print(1)
        print(timeTableIdx)
        setMainTimeTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setMainTimeTable)))
        
        changeStyleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goChangeStyleVC)))
        
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
    
    @objc func setMainTimeTable(sender:UIGestureRecognizer){
        print(2)
               print(timeTableIdx)
        self.updateMainTimeTable()
        print(3)
               print(timeTableIdx)
    }
    
    @objc func goChangeStyleVC(sender:UIGestureRecognizer){
        print("스타일 바꾸기")
    }
    
    @objc func saveImage(sender:UIGestureRecognizer){
        print("이미지로 저장")
    }
    
    @objc func moveToTrash(sender:UIGestureRecognizer){
        print("시간표 삭제")
    }
    
    
    
    func updateMainTimeTable(){
           print("getTimeTable")
            print("timeTable", timeTableIdx)
        MainTimeTableService.shared.updateMainTimeTable(idx: self.timeTableIdx){ networkResult in
                switch networkResult {
                    case .success(_, _) :
                        print("메인 시간표 변경 성공! -> 토스트로 주면 좋을 텐데,,")
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
