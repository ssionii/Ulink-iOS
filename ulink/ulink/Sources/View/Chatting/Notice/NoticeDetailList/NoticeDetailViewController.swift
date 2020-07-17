//
//  NoticeDetailViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/08.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import Alamofire

class NoticeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    var categoryIdx : Int = 0
    var subjectIdx : Int = 1
    var hwNoticeInfoArray : [noticeInformation] = []
    var testNoticeInfoArray : [noticeInformation] = []
    var classNoticeInfoArray : [noticeInformation] = []
    
    @IBOutlet weak var noticeDetailTableView: UITableView!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        setTitle()
        
        setTableView()
        loadNoticeData()

        
        
        
        print("=====================================")
        print("현재 공지사항 목록 뷰의 정보")
        print("현재 공지의 카테고리 idx : \(self.categoryIdx)")
        print("현재 클릭한 공지의 과목 idx : \(self.subjectIdx)")
        print("=====================================")
        
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
                self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func hideNaviBar(){
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setTableView(){
        
        
        self.noticeDetailTableView.dataSource = self
        self.noticeDetailTableView.delegate = self
        
    }
    
    func setTitle()
    {
        
        if categoryIdx == 1
        {
            
            titleLabel.text = "과제 공지"
            
        }
        else if categoryIdx == 2
        {
            titleLabel.text = "시험 공지"
        }
        
        else if categoryIdx == 3
        {
            titleLabel.text = "수업 공지"
        }
        
        else
        {
            titleLabel.text = "공지"
        }
    }
    
    
    func loadNoticeData(){
        
        
        
        NoticeService.shared.getSubjectNotice(subjectIdx: subjectIdx) { networkResult in
            switch networkResult{
                
            case .success(let noticeList, let numberOfNotice):
                
                print(noticeList)
                print(numberOfNotice)
                
                guard let noticeList = noticeList as? [[SubjectNoticeData]] else { return }
                guard let numberOfNotice = numberOfNotice as? [Int] else {return}
                
                if numberOfNotice[0] > 0
                {
                    for i in 0...numberOfNotice[0]-1 // 과제 공지 부분
                    {
                        let noticeData = noticeInformation(title: noticeList[0][i].title , start: noticeList[0][i].startTime, end: noticeList[0][i].endTime, Date: noticeList[0][i].date, idx: noticeList[0][i].noticeIdx)
                        
                        self.hwNoticeInfoArray.append(noticeData)
                        
                    }
                }
                
                
                
                
                if numberOfNotice[1] > 0
                {
                    for i in 0...numberOfNotice[1]-1 // 시험 공지 부분
                    {
                        let noticeData = noticeInformation(title: noticeList[1][i].title , start: noticeList[1][i].startTime, end: noticeList[1][i].endTime, Date: noticeList[1][i].date, idx: noticeList[1][i].noticeIdx)
                        
                        self.testNoticeInfoArray.append(noticeData)
                    }
                }
                
                if numberOfNotice[2] > 0
                {
                    for i in 0...numberOfNotice[2]-1 // 수업 공지 부분
                    {
                        let noticeData = noticeInformation(title: noticeList[2][i].title , start: noticeList[2][i].startTime, end: noticeList[2][i].endTime, Date: noticeList[2][i].date, idx: noticeList[2][i].noticeIdx)
                        
                        self.classNoticeInfoArray.append(noticeData)
                    }
                    
                    
                }
                
                
                
                
            default:
                print("fail")
                
                
            }
            
            
            print(self.hwNoticeInfoArray.count)
            print(self.testNoticeInfoArray.count)
            print(self.classNoticeInfoArray.count)
            
            self.noticeDetailTableView.reloadData()
            
            
        }
        
        

        

    }
    


}


extension NoticeDetailViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(categoryIdx == 1)
        {
            return hwNoticeInfoArray.count
        }
        else if(categoryIdx == 2)
        {
            return testNoticeInfoArray.count
        }
        else
        {
            return classNoticeInfoArray.count

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    
        guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeDetailCell", for: indexPath) as? NoticeDetailTableCell
        else { return UITableViewCell() }
        
        
        
        
        if(categoryIdx == 1)
        {
            noticeCell.setData(
                title: hwNoticeInfoArray[indexPath.row].title,
                date: hwNoticeInfoArray[indexPath.row].date,
                start: hwNoticeInfoArray[indexPath.row].startTime,
                end: hwNoticeInfoArray[indexPath.row].endTime
            )
            
            noticeCell.setImage(imageIdx: 1)
        }
        else if(categoryIdx == 2)
        {
            noticeCell.setData(
                title: testNoticeInfoArray[indexPath.row].title,
                date: testNoticeInfoArray[indexPath.row].date,
                start: testNoticeInfoArray[indexPath.row].startTime,
                end: testNoticeInfoArray[indexPath.row].endTime
            )
            
            noticeCell.setImage(imageIdx: 2)
            
        }
        else
        {
            noticeCell.setData(
                title: classNoticeInfoArray[indexPath.row].title,
                date: classNoticeInfoArray[indexPath.row].date,
                start: classNoticeInfoArray[indexPath.row].startTime,
                end: classNoticeInfoArray[indexPath.row].endTime
            )
            
             noticeCell.setImage(imageIdx: 3)
        }
        
        
        
        
        return noticeCell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let noticeViewController = self.storyboard?.instantiateViewController(identifier: "NoticeEditViewController") as? NoticeEditViewController else { return }
        
        
        
                if(categoryIdx == 1)
                {
                
                    noticeViewController.noticeIdx = hwNoticeInfoArray[indexPath.row].noticeIdx


                }
        
                else if(categoryIdx == 2)
                {
                    noticeViewController.noticeIdx = testNoticeInfoArray[indexPath.row].noticeIdx

                }
        
                else
                {
                    noticeViewController.noticeIdx = classNoticeInfoArray[indexPath.row].noticeIdx
                }
            noticeViewController.cateogoryIdx = categoryIdx
        
        self.navigationController?.pushViewController(noticeViewController, animated: true)
        
    }
    
    
    
}
