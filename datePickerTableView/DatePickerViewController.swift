//
//  DatePickerViewController.swift
//  datePickerTableView
//
//  Created by Joshua Chang on 2018/12/19.
//  Copyright © 2018 Joshua Chang. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    private var startDate: Date?
    private var expireDate: Date?
    
    // MARK: - IBOutlet
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var expireButton: UIButton!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var expireDatePicker: UIDatePicker!
    
    
    // MARK: - IBAction
    @IBAction func dateSelector(_ sender: Any) {
        guard let chick = sender as? UIButton else { return }
        if chick == startButton {
            startButton.setTitleColor(.white, for: .normal)
            startButton.backgroundColor = UIColor.orange
            expireButton.setTitleColor(.gray, for: .normal)
            expireButton.backgroundColor = UIColor.clear
            startDatePicker.isHidden = false
            expireDatePicker.isHidden = true
        } else if chick == expireButton {
            expireButton.setTitleColor(.white, for: .normal)
            expireButton.backgroundColor = UIColor.orange
            startButton.setTitleColor(.gray, for: .normal)
            startButton.backgroundColor = UIColor.clear
            startDatePicker.isHidden = true
            expireDatePicker.isHidden = false
        }
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        guard let picker = sender as? UIDatePicker else { return }
        let dateString = DateFormatter.localizedString(from: picker.date, dateStyle: .short, timeStyle: .short)
        if picker == startDatePicker {
            startButton.setTitle(dateString, for: .normal)
        } else if picker == expireDatePicker {
            expireButton.setTitle(dateString, for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startDatePicker.isHidden = false
        expireDatePicker.isHidden = true
    }
    
    func configInit() {
        // corner init
        UISetting.UI.setCorner(customView: startButton, radius: 20)
        UISetting.UI.setCorner(customView: expireButton, radius: 20)
        
        // time of date picker init
        startDatePicker.date = startDate ?? Date()
        expireDatePicker.date = expireDate ?? Date() + 3600
        
        // date formatter init
        let formatter = DateFormatter()
        formatter.formatterBehavior = .default
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        // button content init
        let startTime = formatter.string(from: startDatePicker.date)
        let expireTime = formatter.string(from: expireDatePicker.date)
        startButton.setTitle(startTime, for: .normal)
        expireButton.setTitle(expireTime, for: .normal)
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
