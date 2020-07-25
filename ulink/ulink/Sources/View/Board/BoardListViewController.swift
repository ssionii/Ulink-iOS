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
    
    
    var chattingList : [ChattingListData] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getBoardListData()

        
        BoardListTableView.delegate = self
        BoardListTableView.dataSource = self
        hideNaviBar()
        
    }
    
    
    func hideNaviBar()
    {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getBoardListData()
    {
        


          LoadChattingListService.shared.getSubjectDetailNotice() { networkResult in
              switch networkResult{

              case .success(let chatList, let numberOfChatrooms):

                

                  guard let chatList = chatList as? [ChattingListData] else { return }
                  guard let numberOfChatrooms = numberOfChatrooms as? Int else {return}


                      if numberOfChatrooms > 0
                      {
                              for i in 0...numberOfChatrooms - 1 // 게시판 갯수만큼 리스트에 append 해야 함
                              {
                                  let chatroomData = ChattingListData(
                                      idx: chatList[i].subjectIdx,
                                      name: chatList[i].name,
                                      color: chatList[i].color,
                                      total: chatList[i].total,
                                      current: chatList[i].current)

                                  self.chattingList.append(chatroomData)
                              }

                      }





                  self.BoardListTableView.reloadData()


              default:
                  print("fail")


              }




          }


    }
    
    
    
    

    
}


extension BoardListViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chattingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let boardCell = tableView.dequeueReusableCell(withIdentifier: "boardCell", for: indexPath) as? BoardListTableCell
            else { return UITableViewCell() }
        
        
        boardCell.setBoardData(title: chattingList[indexPath.row].name)
        
        
        return boardCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let boardArticleListViewController = self.storyboard?.instantiateViewController(identifier: "BoardArticleListViewController")  as? BoardArticleListViewController else {
            return }
        
        
//        chatList[i].subjectIdx 얘를 다음 화면으로 넘겨야 한다!!
        
        
        self.navigationController?.pushViewController(boardArticleListViewController, animated: true)
        
        
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
        
    }
    
}






