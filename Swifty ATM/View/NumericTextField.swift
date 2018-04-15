//
//  NumericTextField.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 4/15/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit
import Foundation

class NumericTextField: AddUsersTextField {
//    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//            return false
//        }
//        return super.canPerformAction(action, withSender: sender)
//    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
