//
//  CreateTimeTableViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/07.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class CreateTimeTableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeTableCollectionView: UICollectionView!
    
    @IBAction func finishVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private var timeTableList : [TimeTableModel] = []
    
    private var subjectList : [Subject] = []
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setBackgroundView()
        setTimeTableList()
       // setCollectionView()
        
        timeTableCollectionView.dataSource = self
        timeTableCollectionView.delegate = self
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setCollectionView(){
        timeTableCollectionView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft)))
        
        timeTableCollectionView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swipeRight)))
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
        
        timeTableList = [timeTable_1, timeTable_1]
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
    
    
    // protocol 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeTableList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let createTimeTableCell : CreateTimeTableCell = timeTableCollectionView.dequeueReusableCell(withReuseIdentifier: "createTimeTableCell", for: indexPath) as? CreateTimeTableCell else {return CreateTimeTableCell()}
           
        let data = timeTableList[indexPath.row]
        
        createTimeTableCell.setCreateTimeTableCell(idx: data.idx, name: data.name, subjectList:data.subjectList)
           
        return createTimeTableCell
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

}

