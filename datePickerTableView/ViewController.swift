//
//  ViewController.swift
//  datePickerTableView
//
//  Created by Joshua Chang on 2018/12/19.
//  Copyright © 2018 Joshua Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePickerView: UIView!
    @IBAction func datePicker(_ sender: UIButton) {
        datePickerView.isHidden = !datePickerView.isHidden
        if datePickerView.isHidden == false {
            UIView.animate(withDuration: 1) {
                UISetting.UI.shadowEffect(customView: self.datePickerView)
                self.datePickerView.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.datePickerView.alpha = 0.0
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // UI setting
    func initUI() {
        UISetting.UI.setCorner(customView: datePickerView, radius: 20)
        datePickerView.isHidden = true
        datePickerView.alpha = 0.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
