//
//  SearchViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/12.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
   
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    
    let searchedData = SearchedListData()
    var currentText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "ioMainFiltersettingSearchBg")!)
        
        searchTextField.delegate = self
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    @IBAction func backToTimeTable(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func testBtn(_ sender: Any) {
        headerView.isHidden = true
    }
    
    //MARK: 테이블뷰
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchedCell.identifier) as? SearchedCell else {
        return UITableViewCell() }
        
        cell.layer.addBorder(edge: [.bottom], color: UIColor.veryLightPinkTree, thickness: 1)
        
        
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: RealTimeSearchCell.identifier) as? RealTimeSearchCell else {
        return UITableViewCell() }
        
        
        if headerView.isHidden == true {
            return cell2
        } else {
            return cell
        }
        
    }
    
    
    // MARK: 텍스트필드
    //엔터치면 키보드 내려오기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchView.endEditing(true)
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.headerView.frame.width, height: 0)
        headerView.isHidden = true
        searchTableView.reloadData()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.headerView.frame.width, height: 20)
        headerView.isHidden = false
        searchTableView.reloadData()
        return true
    }

    //텍스트필드 칠때마다 값 받아오기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        currentText = textField.text! + string
        //print("오오잉", currentText)
        //요기서 통신 가능???
        //요기서 테이블뷰 업데이트 가능???
        
        return true
    }
}
