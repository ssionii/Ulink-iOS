//
//  DetailEventViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/06.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class DetailEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var detailEventCollectionView: UICollectionView!
    @IBOutlet var backView: UIView!
    
    var started = false //시작할때 위치 찾기 한번만~
    
    var numOfDetailCells: Int?
    var currentYear: Int?
    var currentMonth: Int?
    var currentDate: Int?
    var currentWeekDay: Int?
    
    //오늘 날짜 데이터
    let cal = Calendar(identifier: .gregorian)
    let today = Date()
    var todayMonth = Calendar.current.component(.month, from: Date())
    var todayYear = Calendar.current.component(.year, from: Date())
    var todayDate = Calendar.current.component(.day, from: Date())
    
    //더미데이터입니다룰루루얼쟈ㅓㅇㅍㅊ
    let eventName = ["영상처리 과제", "되게 되게 길게 만들어볼까요 더더더더더더더", "소프트웨어개론 퀴즈"]
    let category = [2, 1, 0]
    let time = ["", "", "11:00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMonthlyData()
        
        
        // Do any additional setup after loading the view.
        detailEventCollectionView.dataSource = self
        detailEventCollectionView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view != self.detailEventCollectionView
        { self.dismiss(animated: false, completion: nil) }
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        let x = self.detailEventCollectionView.bounds.origin.x
        if (x < (self.detailEventCollectionView.frame.width-45) * 2){
            self.detailEventCollectionView.setContentOffset(CGPoint(x: self.detailEventCollectionView.bounds.origin.x + self.detailEventCollectionView.frame.width - 45, y: 0), animated: true)
        }
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        let x = self.detailEventCollectionView.bounds.origin.x
        if (x > 0){
            self.detailEventCollectionView.setContentOffset(CGPoint(x: self.detailEventCollectionView.bounds.origin.x - self.detailEventCollectionView.frame.width + 45, y: 0), animated: true)
        }
    }
    
    func getMonthlyData(){
        guard let numOfDetailCells = self.numOfDetailCells else {return}
        guard let currentYear = self.currentYear else {return}
        guard let currentMonth = self.currentMonth else {return}
        guard let currentDate = self.currentDate else {return}
        guard let currentWeekDay = self.currentWeekDay else {return}
        
        print("개수", numOfDetailCells, "년", currentYear, "월", currentMonth, "일", currentDate)
    }
    
    func changeWeekdayToString(weekday: Int) -> String{
        var stringWeekday: String
        switch weekday {
        case 1:
            stringWeekday = "일"
        case 2:
            stringWeekday = "월"
        case 3:
            stringWeekday = "화"
        case 4:
            stringWeekday = "수"
        case 5:
            stringWeekday = "목"
        case 6:
            stringWeekday = "금"
        case 7:
            stringWeekday = "토"
        default:
            stringWeekday = ""
        }

        //var dateString = String(currentMonth?) + "월 " + String(currentDate?) + "일 "
        
        
        return stringWeekday
    }
    
    // MARK: collectionview layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    // MARK: collectionview cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailEventCell.identifier, for: indexPath) as? DetailEventCell else {
        return UICollectionViewCell() }
        

        var weekday = changeWeekdayToString(weekday: currentWeekDay!)
        var date = String(currentMonth!) + "월 " + String(currentDate!) + "일 "
        date.insert(contentsOf: weekday, at: date.endIndex)
        cell.setEventList(date: date, eventName: eventName, category: category, time: time)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (started == false){
            started = true
            self.detailEventCollectionView.setContentOffset(CGPoint(x: self.detailEventCollectionView.bounds.origin.x + self.detailEventCollectionView.frame.width - 45, y: 0), animated: false)
        }

    }

}
