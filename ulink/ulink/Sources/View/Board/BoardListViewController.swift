//
//  BoardListViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/23.
//  Copyright © 2020 송지훈. All rights reserved.
//

// 게시판 목록 보는 뷰컨

import UIKit

class BoardListViewController: UIViewController {

    @IBOutlet weak var BoardListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BoardListTableView.delegate = self
        BoardListTableView.dataSource = self
        hideNaviBar()
        
        
    }
    
    
    func hideNaviBar()
    {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    

    
}


extension BoardListViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let boardCell = tableView.dequeueReusableCell(withIdentifier: "boardCell", for: indexPath) as? BoardListTableCell
            else { return UITableViewCell() }
        
        
        boardCell.setBoardData(title: "게시판 이름 여기에")
        
        
        return boardCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let boardArticleListViewController = self.storyboard?.instantiateViewController(identifier: "BoardArticleListViewController")  as? BoardArticleListViewController else {
            return }
        
        
        
        self.navigationController?.pushViewController(boardArticleListViewController, animated: true)
        
        
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
        
    }
    
}



//
//
//extension NoticeViewController: UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if tableView == hwNoticeTableView{
//            return hwNoticeInfoArray.count
//
//        }
//
//
//        else if tableView == testNoticeTableView{
//
//
//            return testNoticeInfoArray.count
////            return testNoticeInfoArray.count
//        }
//
//        else{
//            return classNoticeInfoArray.count
//        }
//    }
//
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//
//
//
//        if tableView == hwNoticeTableView{
//
//
//            if hwNoticeInfoArray.count == 0
//            {
//                self.hideView1.isHidden = false
//            }
//
//            else {
//                self.hideView1.isHidden = true
//            }
//
//            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as? NoticeTableViewCell
//                else { return UITableViewCell() }
//
//
//
//            noticeCell.setInformation(
//                title: hwNoticeInfoArray[indexPath.row].title,
//                start: hwNoticeInfoArray[indexPath.row].startTime,
//                end: hwNoticeInfoArray[indexPath.row].endTime,
//                date: hwNoticeInfoArray[indexPath.row].date)
//
//
//
//            let bgColorView = UIView()
//            bgColorView.backgroundColor = .noticeColorOneSelected
//            noticeCell.selectedBackgroundView = bgColorView
//
//
//            noticeCell.layer.borderColor = .none
//
//
//            return noticeCell
//
//
//        }
//
//        if tableView == testNoticeTableView{
//
//
//            if testNoticeInfoArray.count == 0
//            {
//
//                print("안보여야 하는데...")
//                self.hideView2.isHidden = false
//            }
//
//            else {
//
//                print("안봄안봄")
//                self.hideView2.isHidden = true
//            }
//
//
//
//            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCellTwo", for: indexPath) as? NoticeTableViewCellTwo
//
//                else { return UITableViewCell() }
//
//
//
//            noticeCell.setInformation(
//                Title: testNoticeInfoArray[indexPath.row].title,
//                start: testNoticeInfoArray[indexPath.row].startTime,
//                end: testNoticeInfoArray[indexPath.row].endTime,
//                date: testNoticeInfoArray[indexPath.row].date)
//
//
//
//            let bgColorView = UIView()
//            bgColorView.backgroundColor = .noticeColorTwoSelected
//            noticeCell.selectedBackgroundView = bgColorView
//
//
//            noticeCell.layer.borderColor = .none
//
//
//            return noticeCell
//
//        }
//
//        else{
//
//
//            if classNoticeInfoArray.count == 0
//            {
//                self.hideView3.isHidden = false
//            }
//
//            else {
//                self.hideView3.isHidden = true
//            }
//
//
//
//
//
//            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCellThree", for: indexPath) as? NoticeTableViewCellThree
//                else { return UITableViewCell() }
//
//
//
//            noticeCell.setInformation(
//                Title: classNoticeInfoArray[indexPath.row].title,
//                start: classNoticeInfoArray[indexPath.row].startTime,
//                end: classNoticeInfoArray[indexPath.row].endTime,
//                date: classNoticeInfoArray[indexPath.row].date)
//
//
//
//            let bgColorView = UIView()
//            bgColorView.backgroundColor = .noticeColorThreeSelected
//            noticeCell.selectedBackgroundView = bgColorView
//
//
//            noticeCell.layer.borderColor = .none
//
//
//            return noticeCell
//        }
//
//
//
//    }
//
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//            return 45
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//
//        guard let noticeDetailVC = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else {
//            return }
//
//
//        guard let noticeViewController = self.storyboard?.instantiateViewController(identifier: "NoticeEditViewController") as? NoticeEditViewController else {
//            return }
//
//
//
//        if tableView == hwNoticeTableView{
//
//
//
//            noticeViewController.noticeIdx = hwNoticeInfoArray[indexPath.row].noticeIdx
//
//            noticeViewController.subjectIDX = self.subjectIDX
//
//            print("=====================================")
//            print("셀을 눌러서 공지 상세보기로 넘기는 정보")
//            print("현재 클릭한 공지의 idx : \(hwNoticeInfoArray[indexPath.row].noticeIdx)")
//            print("현재 클릭한 공지의 과목 idx : \(self.subjectIDX)")
//            print("=====================================")
//            noticeViewController.cateogoryIdx = 1
//
//
//
//
//
//
//
//
//
//
//
//
//
//        self.navigationController?.pushViewController(noticeViewController, animated: true)
//
//
//
//    }
//
//
//
//}
