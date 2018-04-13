//
//  AdminOptions.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/22/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import Foundation

class AdminOptions{
    var optionTitle = String()
    var optionSubTitle = String()
    
    init(optionTitle: String, optionSubTitle: String) {
        self.optionSubTitle = optionSubTitle
        self.optionTitle = optionTitle
    }
}
