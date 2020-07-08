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
    
    private func setViewTap(){
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
        print("대표 시간표 설정 클릭")
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
    
}
