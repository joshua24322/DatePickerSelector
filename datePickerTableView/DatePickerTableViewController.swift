//
//  DatePickerTableViewController.swift
//  datePickerTableView
//
//  Created by Joshua Chang on 2018/12/17.
//  Copyright © 2018 Joshua Chang. All rights reserved.
//

import UIKit

class DatePickerTableViewController: UITableViewController {
    
    // Submit
    @IBOutlet weak var submitButton: UIButton!
    
    // Start Date
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    var startDatePickerVisible: Bool?
    
    // End Date
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    var endDatePickerVisible: Bool?
    
    private var startDate: Date?
    private var endDate: Date?
    // Backup date labels' initial text color, to restore on collapse
    // (we change it to control tint while expanded, like calendar.app)
    private var dateLabelInitialTextColor: UIColor!
    
    // MARK: - Date Picker Control Actions
    @IBAction func dateChanged(sender: AnyObject) {
        guard let picker = sender as? UIDatePicker else { return }
        let dateString = DateFormatter.localizedString(from: picker.date, dateStyle: .short, timeStyle: .short)
        if picker == startDatePicker {
            startDateLabel.text = dateString
        } else if picker == endDatePicker {
            endDateLabel.text = dateString
        }
        
        if startDateLabel.text != endDateLabel.text {
            submitButton.setTitle("Submit", for: .normal)
            submitButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set pickers to their initial values (e.g., "now" and "now + 1hr" )
        startDatePicker.date = startDate ?? Date()
        startDateLabel.text = DateFormatter.localizedString(from: startDatePicker.date, dateStyle: .short, timeStyle: .short)
        
        endDatePicker.date = endDate ?? Date()
        endDateLabel.text = DateFormatter.localizedString(from: endDatePicker.date, dateStyle: .short, timeStyle: .short)
        
        // Backup (unselected) date label color
        dateLabelInitialTextColor = startDateLabel.textColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startDatePickerVisible = false
        startDatePicker.isHidden = true
        
        endDatePickerVisible = false
        endDatePicker.isHidden = true
    }
    
    // MARK: - Auxiliary Methods: (animation, date formatting)
    func showDatePickerCell(containingDatePicker picker: UIDatePicker) {
        if picker == startDatePicker {
            startDatePickerVisible = true
            startDateLabel.textColor = UIColor.orange
        } else if picker == endDatePicker {
            endDatePickerVisible = true
            endDateLabel.textColor = UIColor.orange
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        
        picker.isHidden = false
        picker.alpha = 0.0
        
        UIView.animate(withDuration: 0.25) {
            picker.alpha = 1.0
        }
    }
    
    func hideDatePickerCell(containingDatePicker picker: UIDatePicker) {
        if picker == startDatePicker {
            startDatePickerVisible = false
            startDateLabel.textColor = dateLabelInitialTextColor
        } else if picker == endDatePicker {
            endDatePickerVisible = false
            endDateLabel.textColor = dateLabelInitialTextColor
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        
        UIView.animate(withDuration: 0.25, animations: {
            picker.alpha = 0.0
        }) { (finished) in
            picker.isHidden = true
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        print("indexPath.row: \(String(describing: cell?.textLabel?.text))")
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                // [ A ] START DATE
                
                // Collapse the other date picker (if expanded):
                if endDatePickerVisible! {
                    hideDatePickerCell(containingDatePicker: endDatePicker)
                }
                
                // Expand:
                if startDatePickerVisible! {
                    hideDatePickerCell(containingDatePicker: startDatePicker)
                }
                else{
                    showDatePickerCell(containingDatePicker: startDatePicker)
                }
                
            case 2:
                // [ B ] END DATE
                
                // Collapse the other date picker (if expanded):
                if startDatePickerVisible!{
                    hideDatePickerCell(containingDatePicker: startDatePicker)
                }
                
                // Expand:
                if endDatePickerVisible! {
                    hideDatePickerCell(containingDatePicker: endDatePicker)
                }
                else{
                    showDatePickerCell(containingDatePicker: endDatePicker)
                }
                
            default:
                break
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 44 // Default
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 1:
                // START DATE PICKER ROW
                if let startDatePickerVisible = startDatePickerVisible {
                    height = startDatePickerVisible ? 216 : 0
                }
            case 3:
                // END DATE PICKER ROW
                if let endDatePickerVisible = endDatePickerVisible {
                    height = endDatePickerVisible ? 216 : 0
                }
            default:
                break
            }
        }
        return height
    }
    
    
    
    
    
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
