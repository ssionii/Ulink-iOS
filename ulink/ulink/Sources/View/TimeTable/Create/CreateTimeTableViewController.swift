//
//  CreateTimeTableViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/07.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class CreateTimeTableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeTableCollectionView: UICollectionView!
    @IBOutlet weak var pageControlDots: UIPageControl!
    @IBOutlet weak var subjectInfoTableView: UITableView!
    
    // button
    @IBOutlet weak var filterAndSearchView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterImageView: UIImageView!
    @IBOutlet weak var filterBottomView: UIView!
    
    @IBOutlet weak var candidateView: UIView!
    @IBOutlet weak var candidateImageView: UIImageView!
    @IBOutlet weak var candidateLabel: UILabel!
    @IBOutlet weak var candidateBottomView: UIView!
    

    @IBAction func finishVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTimeTableSheet(_ sender: UIButton) {
        let alertController = UIAlertController(title: "시간표 이름을 입력해 주세요.", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
        
                let newTimeTableSheet = TimeTableModel(idx: 0, name: text, subjectList: [])
                self.timeTableList.append(newTimeTableSheet)
                
                DispatchQueue.global().sync {
                    self.timeTableCollectionView.reloadData()
                }
                
                print("이동할 곳: ", self.timeTableCollectionView.numberOfItems(inSection: 0) - 2)
                self.timeTableCollectionView.scrollToItem(at: IndexPath(item: self.timeTableCollectionView.numberOfItems(inSection: 0) -  2, section: 0), at: .right, animated: true)
                
                UIView.animate(withDuration: 0.2, animations: {
                     self.timeTableCollectionView.contentOffset.x = 11
                })
                
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "시간표 이름"
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addSubjectDirect(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil , message: "과목추가 방식을 선택해주세요.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "드래그로 추가", style: .default, handler: { (_) in
                
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "addSubjectByDragViewController") as? AddSubjectByDragViewController else { return }
                   
                   nextVC.modalPresentationStyle = .fullScreen
                    self.present(nextVC, animated: true, completion: nil)
            
            
            }))

        alert.addAction(UIAlertAction(title: "직접 입력", style: .default, handler: { (_) in
              
            
            
            }))


        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    private var timeTableList : [TimeTableModel] = []
    private var subjectInfoList : [SubjectModel] = []
    
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundView()
        setTimeTableList()
        setSubjectInfoList()
        
        setSearchView()
        setButton()
        setSubjectInfoTableView()
        // setCollectionView()
        
        timeTableCollectionView.dataSource = self
        timeTableCollectionView.delegate = self
        
        subjectInfoTableView.dataSource = self
        subjectInfoTableView.delegate = self
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setCollectionView(){
        timeTableCollectionView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft)))
        
        timeTableCollectionView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swipeRight)))
    }
    
    private func setSearchView(){
        
        
    }
    
    private func setSubjectInfoTableView(){
        subjectInfoTableView.bounces = false
    }
    
    private func setButton(){
        self.filterAndSearchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapFilterAndSearch)))
        
        self.candidateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapCandidate(recognizer:))))

      
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        let x = self.timeTableCollectionView.bounds.origin.x
        if x < (self.timeTableCollectionView.frame.width - 11) * 2 {
            self.timeTableCollectionView.setContentOffset(CGPoint(x: self.timeTableCollectionView.bounds.origin.x + self.timeTableCollectionView.frame.width - 11, y: 0), animated: true)
        }
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        let x = self.timeTableCollectionView.bounds.origin.x
        if x > 0 {
            self.timeTableCollectionView.setContentOffset(CGPoint(x: self.timeTableCollectionView.bounds.origin.x - self.timeTableCollectionView.frame.width + 11, y: 0), animated: true)
        }
    }
    
    private func setTimeTableList(){
        
        let timeTable_1 = TimeTableModel(idx: 0, name: "시간표1", subjectList: [])
        let timeTable_2 = TimeTableModel(idx: 0, name: "시간표2", subjectList: [])
        
        timeTableList = [timeTable_1, timeTable_2]
    }
    
    
    private func setSubjectInfoList(){
        let subjectInfo_1 = SubjectModel(subjectName: "가정과학론", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 3)
        
        let subjectInfo_2 = SubjectModel(subjectName: "가정과학론", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 3)
        
        let subjectInfo_3 = SubjectModel(subjectName: "가정과학론", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 2)
        
        subjectInfoList = [subjectInfo_1, subjectInfo_2, subjectInfo_3]
        
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
    
    func addEmptyTimeTable(){
        
        timeTableList.append(TimeTableModel(idx: 1, name: "시간표3", subjectList: []))
        self.timeTableCollectionView.reloadData()
        
    }
    
    
    // protocol 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = timeTableList.count + 1
        pageControlDots.numberOfPages = count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
        if(indexPath.row < timeTableList.count){
            guard let createTimeTableCell : CreateTimeTableCell = timeTableCollectionView.dequeueReusableCell(withReuseIdentifier: "createTimeTableCell", for: indexPath) as? CreateTimeTableCell else {return CreateTimeTableCell()}
               
            let data = timeTableList[indexPath.row]
            
            createTimeTableCell.setCreateTimeTableCell(idx: data.idx, name: data.name, subjectList:data.subjectList)
               
            return createTimeTableCell
        }else{
            guard let addSheetCell : CreateNewSheetCell = timeTableCollectionView.dequeueReusableCell(withReuseIdentifier: "createNewSheetCell", for: indexPath) as? CreateNewSheetCell else {return CreateNewSheetCell()}
                      
                    
            return addSheetCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
           indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width - 22, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == timeTableList.count {
          
            self.timeTableList.append(TimeTableModel(idx: 1, name: "시간표3", subjectList: []))
            
            DispatchQueue.global().sync {
                self.timeTableCollectionView.reloadData()
            }
    
            print("timeTableList: \(timeTableList)")
        
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControlDots.currentPage = Int(
            (self.timeTableCollectionView.contentOffset.x / self.timeTableCollectionView.frame.width)
            .rounded(.toNearestOrAwayFromZero)
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectInfoList.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let subjectInfoCell : SubjectInfoCell = subjectInfoTableView.dequeueReusableCell(withIdentifier: "subjectInfoCell", for: indexPath) as? SubjectInfoCell else {return SubjectInfoCell()}
             
        let data = subjectInfoList[indexPath.row]
          
        subjectInfoCell.setSubjectInfoData(name: data.subjectName, professorName: data.professorName, timeInfo: data.timeInfo, room: data.roomName, category: data.course, credit: data.credit)
        
        
        
        if indexPath.row == subjectInfoList.count - 1{
            subjectInfoCell.hideBorder()
        }else{
            subjectInfoCell.showBorder()
        }
             
          return subjectInfoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
    
    
    // gestureRecognizer
    @objc func handleTapFilterAndSearch(recognizer: UITapGestureRecognizer) {

        // 선택 처리
        self.filterLabel.textColor = UIColor.purpleishBlueThree
        self.filterImageView.image = UIImage(named: "timetableaddFilterandsearchBtnFilterandsearchOn.png")
        self.filterBottomView.backgroundColor = UIColor.purpleishBlueThree

        self.candidateLabel.textColor = UIColor.brownGreyFive
        self.candidateImageView.image = UIImage(named: "timetableaddFilterandsearchBtnCandidateOff.png")
        self.candidateBottomView.backgroundColor = UIColor.clear
        
       let subjectInfo_1 = SubjectModel(subjectName: "전자회로1", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 3)
        
        let subjectInfo_2 = SubjectModel(subjectName: "전자회로", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 3)
        
        let subjectInfo_3 = SubjectModel(subjectName: "전자회로!", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 2)
        
        subjectInfoList = [subjectInfo_1, subjectInfo_2, subjectInfo_3]
        
        self.subjectInfoTableView.reloadData()
        
    }

    @objc func handleTapCandidate(recognizer: UITapGestureRecognizer) {

           // 선택 처리
           self.filterLabel.textColor = UIColor.brownGreyFive
           self.filterImageView.image = UIImage(named: "timetableaddFilterandsearchBtnFilterandsearchOff.png")
           self.filterBottomView.backgroundColor = UIColor.clear

           self.candidateLabel.textColor = UIColor.purpleishBlueThree
           self.candidateImageView.image = UIImage(named: "timetableaddFilterandsearchBtnCandidateOn.png")
           self.candidateBottomView.backgroundColor = UIColor.purpleishBlueThree

        let subjectInfo_1 = SubjectModel(subjectName: "후보군", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 3)
        
        let subjectInfo_2 = SubjectModel(subjectName: "후보군", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 3)
        
        let subjectInfo_3 = SubjectModel(subjectName: "후보군이라굿!", professorName: "최성일", timeInfo: "월 10:00 - 12:00, 화 13:00 - 15:00", roomName: "명신관614", course: "전공선택", credit: 2)
        
        subjectInfoList = [subjectInfo_1]
        
        
        self.subjectInfoTableView.reloadData()
           
       }
}
