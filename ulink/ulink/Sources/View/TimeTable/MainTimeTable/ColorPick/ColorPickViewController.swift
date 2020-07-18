//
//  ColorPickViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol ColorPickerViewControllerDelegate {
    func colorUpdate(color: Int)
}

class ColorPickViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    public var delegate : ColorPickerViewControllerDelegate?
    
    public var subjectIdx = 0
    public var isSubject = true
    public var subjectName = ""
    
    let colorList = ColorPicker().getColorList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        okBtn.isHidden = true
        
        pageControl.numberOfPages = (colorList.count / 8) + 1
        pageControl.tintColor = UIColor.brownGreyFive
        
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        
        setupGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        subjectNameLabel.text = subjectName
        appearAnim()
    }
    
    func appearAnim(){
        self.bottomLayout.constant = 0
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    func disappearAnim(){
        self.bottomLayout.constant = -280
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
        
        self.dismiss(animated: true)
    }
    
    func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ tap: UIGestureRecognizer) {
        disappearAnim()
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorPickCell.identifier, for: indexPath) as? ColorPickCell else { return UICollectionViewCell() }
        
        cell.setColors(colorList[indexPath.row])
        //cell.setColors(ColorPicker.getColorList()[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: collectionView.frame.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if (colorList.count % 8) <= 4 {
            return UIEdgeInsets(top: 16, left: 5, bottom: 10, right: collectionView.frame.width/2 + 10)
        }
        
        return UIEdgeInsets(top: 16, left: 5, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.editColor(idx: self.subjectIdx , isSubject: self.isSubject, color: indexPath.row)
        
        
    }
    
    //페이징
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludeSpacing = colorCollectionView.frame.width

        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index)
        
        pageControl.currentPage = Int(roundedIndex)

        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
  // - scrollView.contentInset.left
    //backView.frame.width + 10
    
    //MARK:- 통신
    func editColor(idx : Int, isSubject : Bool, color : Int){
        print("editColor")
        SubjectDetailService.shared.editSubjectColor(idx: idx, isSubject: isSubject, color : color){ networkResult in
            switch networkResult {
                case .success(let _, _) :
                 print("색상 변경 성공")
                 self.delegate?.colorUpdate(color: color)
                 self.disappearAnim()
                    break
                case .requestErr(let message):
                        print("REQUEST ERROR")
                        break
            case .pathErr: break
            case .serverErr: print("serverErr")
                case .networkFail: print("networkFail")
            }
        }
    }
    
    
    
}

extension ColorPickViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view?.isDescendant(of: backView) ?? false)
    }
}
