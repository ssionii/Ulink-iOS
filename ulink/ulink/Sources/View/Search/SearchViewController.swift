//
//  SearchViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/12.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
   
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var recentLabel: UILabel!
    @IBOutlet weak var deleteAllBtn: UIButton!
    
    @IBOutlet weak var typeBtn: UIButton!
    //디비 불러온다
    let searchedData = SearchedListData()
    var currentText: String = ""
    let realm = try! Realm()
    
    var serverData: [String] = []
    
    var type = "과목명"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setColor()
        
        searchView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "ioMainFiltersettingSearchBg")!)
        
        searchTextField.delegate = self

        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    // MARK: SERVER 통신
    func getDataFromServer(){
        SearchRecommendService.shared.openRecommendData(word: searchTextField.text ?? ""){
                    networkResult in
                    switch networkResult {
                    case .success(let tokenData):
                        guard let token = tokenData as? [String] else {return}
                        self.serverData = token
                        
                        print(self.serverData)
                        
                        self.searchTableView.reloadData()
                    case .requestErr:
                        print("requestErr")
                    case .pathErr:
                        print("pathErr")
                    case .serverErr:
                        print("serverErr")
                    case .networkFail:
                        print("networkFail")
                    }
        }
    }
    
    @IBAction func backToTimeTable(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeSearchType(_ sender: Any) {
        
        if (type == "과목명"){
            type = "교수명"
            typeBtn.setTitle(type, for: .normal)
        } else {
            type = "과목명"
            typeBtn.setTitle(type, for: .normal)
        }
        
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        try! realm.write {
            realm.delete(realm.objects(SearchedListData.self))
        }
        
        searchTableView.reloadData()
    }
    
    func setColor(){
        recentLabel.textColor = UIColor.greyishBrown
        deleteAllBtn.tintColor = UIColor.brownGreySix
    }
    
    //MARK: 테이블뷰
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (headerView.isHidden == true){
            return 3
        } else {
            let savedDatas = realm.objects(SearchedListData.self)
            return savedDatas.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchedCell.identifier) as? SearchedCell else {
        return UITableViewCell() }
        
        
        
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: RealTimeSearchCell.identifier) as? RealTimeSearchCell else {
        return UITableViewCell() }
        
        
        if headerView.isHidden == true {
            return cell2
        } else {
            cell.layer.addBorder(edge: [.bottom], color: UIColor.veryLightPinkTree, thickness: 1)
            cell.set(indexPath.row)
            return cell
        }
        
    }
    
    
    // MARK: 텍스트필드
    //엔터치면 키보드 내려오기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchView.endEditing(true)
        return true
    }

    //텍스트필드 클릭하면
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.headerView.frame.width, height: 0)
        headerView.isHidden = true
        searchTableView.reloadData()
        return true
    }
    
    //엔터치면
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.headerView.frame.width, height: 20)
        headerView.isHidden = false
        
        searchedData.searched = searchTextField.text ?? ""
        
        //db저장
        if (searchTextField.text != ""){
            try! realm.write {
                realm.add(searchedData)
            }
        }

        searchTableView.reloadData()
        return true
    }

    //텍스트필드 칠때마다 값 받아오기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        currentText = textField.text! + string
        //print("오오잉", currentText)
        //요기서 통신 가능???
        //요기서 테이블뷰 업데이트 가능???
        getDataFromServer()
        return true
    }
}
