//
//  MajorFilterViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class MajorFilterViewController: UIViewController {

    
    
    var majorList : [String] = []
    var numberOfSection : Int = 0
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadFilterData()
        
        filterNameView.delegate = self
        filterNameView.dataSource = self
        
  
    }

    @IBOutlet weak var filterNameView: UITableView!
    
    
    
    
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        
        
        
            dismiss(animated: true, completion: nil)
        
        }
    
    
    
    
    
    
    
    
    //filterList,data.count
    
    func loadFilterData()
    {
        
        
        MajorFilterService.shared.getMajorFilter { networkResult in
       
              switch networkResult{
                      
                  
              case .success(let filterList, let count):
                
                
                guard let filterList = filterList as? [String] else {return}
                guard let count  = count as? Int else {return}
                
                
                
                
                self.numberOfSection = count
                
                
                if count > 0
                {
                    for i in 0 ... count-1
                    {
                        self.majorList.append(filterList[i])
                    }
                }
                
                
                
                

                
                  
    
                
                
              default:
                  
                    let alertViewController = UIAlertController(title: "", message: "삭제 완료!",
                                                                preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertViewController.addAction(action)
                    self.present(alertViewController, animated: true, completion: nil)
                  

                    
                  
                  
              }
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

              
                
            


            self.filterNameView.reloadData()
            }
        
        
        
        
        
    }
    
}


extension MajorFilterViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MajorFilterTableViewCell.identifier)    as? MajorFilterTableViewCell else {
            return UITableViewCell() }
        
        
        
        if numberOfSection > 0
        {
            
        
            for i in 0 ... numberOfSection - 1
            {
                
                if indexPath.section == i
                {
                    cell.setData(name: majorList[i], check: false)
                }
                
            }
            
            
            
        }

        
        
        return cell
        
        
        
        
        
        
        
        
        
    }

       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UIView()
        headerView.backgroundColor = .ulinkGray
         return headerView
     }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }

}


