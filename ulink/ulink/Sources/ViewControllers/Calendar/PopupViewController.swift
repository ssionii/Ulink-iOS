//
//  PopupViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/06.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var detailEventCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailEventCollectionView.dataSource = self
        detailEventCollectionView.delegate = self
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        let x = self.detailEventCollectionView.bounds.origin.x
        if (x < (self.detailEventCollectionView.frame.width-45) * 9){
            self.detailEventCollectionView.setContentOffset(CGPoint(x: self.detailEventCollectionView.bounds.origin.x + self.detailEventCollectionView.frame.width - 45, y: 0), animated: true)
        }
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        let x = self.detailEventCollectionView.bounds.origin.x
        if (x > 0){
            self.detailEventCollectionView.setContentOffset(CGPoint(x: self.detailEventCollectionView.bounds.origin.x - self.detailEventCollectionView.frame.width + 45, y: 0), animated: true)
        }
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailEventCell.identifier, for: indexPath) as? DetailEventCell else {
        return UICollectionViewCell() }
        
        return cell
    }
}
