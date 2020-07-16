//
//  ColorPickViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class ColorPickViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    
    let colorList = [ColorList.init(color: UIColor.periwinkleBlueTwo, colorName: "애쉬 퍼플"), ColorList.init(color: UIColor.babyPurple, colorName: "라일락 보라"), ColorList.init(color: UIColor.lightblue, colorName: "스카이 블루"), ColorList.init(color: UIColor.powderPink, colorName: "베이비 핑크"), ColorList.init(color: UIColor.periwinkleBlue, colorName:"문라이트 퍼플"), ColorList.init(color: UIColor.skyBlueTwo, colorName: "마티니 블루"), ColorList.init(color: UIColor.pink, colorName: "라즈베리 핑크"), ColorList.init(color: UIColor.easterPurple, colorName: "와인 퍼플"), ColorList.init(color: UIColor.robinSEgg, colorName: "오션 블루"), ColorList.init(color: UIColor.skyBlue, colorName: "진 블루")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        okBtn.isHidden = true
        
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        
        
        
        setupGestureRecognizer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ tap: UIGestureRecognizer) {
        self.dismiss(animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorPickCell.identifier, for: indexPath) as? ColorPickCell else { return UICollectionViewCell() }
        
        cell.setColors(colorList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: collectionView.frame.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if colorList.count > 8 {
            return UIEdgeInsets(top: 16, left: 5, bottom: 10, right: collectionView.frame.width/2 + 10)
        }
        
        return UIEdgeInsets(top: 16, left: 5, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //통신~~
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludeSpacing = colorCollectionView.frame.width

        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index)

        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
  // - scrollView.contentInset.left
    //backView.frame.width + 10
}

extension ColorPickViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view?.isDescendant(of: backView) ?? false)
    }
}
