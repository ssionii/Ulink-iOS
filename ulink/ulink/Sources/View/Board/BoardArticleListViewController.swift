//
//  BoardArticleListViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/23.
//  Copyright © 2020 송지훈. All rights reserved.
//


// 게시판 내 글 목록 보는 뷰컨


import UIKit



class BoardArticleListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNaviBar()

        // Do any additional setup after loading the view.
    }
     
    func hideNaviBar()
    {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    

    @IBAction func goToNoticeView(_ sender: Any) {
        
                    let storyboard = UIStoryboard(name:"Chatting", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "NoticeViewController") as! NoticeViewController
        
        
        
        
//                    print("=====================================")
//                    print("현재 게시판에서 공지방으로 넘기는 정보")
//                    print("과목 이름 : \(self.tempTitle!)")
//                    print("과목 인덱스 : \(self.subjectIdx)")
//
//                    print("=====================================")
        
        
                    vc.roomtitle = "공지방"
                    vc.subjectIDX = 3
                    self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    

}
