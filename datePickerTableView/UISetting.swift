//
//  UISetting.swift
//  datePickerTableView
//
//  Created by Joshua Chang on 2018/12/20.
//  Copyright © 2018 Joshua Chang. All rights reserved.
//

import Foundation
import UIKit

public class UISetting {
    static let UI = UISetting()
    
    // set corner of UI
    func setCorner(customView: UIView, radius: CGFloat) {
        customView.layer.cornerRadius = radius
        customView.clipsToBounds = true
    }
    
    func shadowEffect(customView: UIView) {
        customView.layer.shadowOffset = CGSize(width: 5, height: 5)
        customView.layer.shadowOpacity = 0.7
        customView.layer.shadowRadius = 20
    }
}
