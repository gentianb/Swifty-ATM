//
//  AddUsersTextField.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 4/8/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

@IBDesignable

class AddUsersTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView(){
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }

}

