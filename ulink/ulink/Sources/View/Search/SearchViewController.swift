//
//  SearchViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/12.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift

protocol SearchVCDelegate{
    func searchedSubjectName(_ subjectName: String)
}

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SearchedCellDelegate {
    
    
    
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
    
    public var delegate: SearchVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setColor()
        
        searchView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "ioMainFiltersettingSearchBg")!)
        
        searchTextField.delegate = self
        
        

        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    // MARK: SERVER 통신
    func getDataFromServer(currentString: String){
        SearchRecommendService.shared.openRecommendData(word: currentString ?? ""){
                    networkResult in
                    switch networkResult {
                    case .success(let tokenData):
                        guard let token = tokenData as? [String] else {return}
                        self.serverData = token
                        
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
    
    // MARK: DELEGATE FUNC
    
    func didPressDeleteButton(_ tag: Int) {
        let savedDatas = realm.objects(SearchedListData.self)
        let predicate = NSPredicate(format: "searched = %@", savedDatas[tag].searched)

        try! self.realm.write({
            realm.delete(realm.objects(SearchedListData.self).filter(predicate))
        })
        
        searchTableView.reloadData()
    }
    
    
    // MARK: IBACTION
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
            return serverData.count
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
            cell2.show(titleString: serverData[indexPath.row])
            return cell2
        } else {
            cell.layer.addBorder(edge: [.bottom], color: UIColor.veryLightPinkTree, thickness: 1)
            cell.set(indexPath.row)
            cell.indexPathNum = indexPath.row
            cell.delegate = self
            return cell
        }
    }
    
    //클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if headerView.isHidden == true {
            searchTextField.text = serverData[indexPath.row]
            self.delegate?.searchedSubjectName(searchTextField.text ?? "")
            self.dismiss(animated: true, completion: nil)
        } else {
            let savedDates = realm.objects(SearchedListData.self)
            searchTextField.text = savedDates[indexPath.row].searched
            self.delegate?.searchedSubjectName(searchTextField.text ?? "")
            self.dismiss(animated: true, completion: nil)

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

        //통신 후 데이터 다음 뷰로 넘겨주기:D
        searchTableView.reloadData()
        
        self.delegate?.searchedSubjectName(searchTextField.text ?? "")
        self.dismiss(animated: true, completion: nil)
        
        return true
    }

    //텍스트필드 칠때마다 값 받아오기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        currentText = textField.text! + string
        getDataFromServer(currentString: currentText)
        searchTableView.reloadData()
        return true
    }

}

