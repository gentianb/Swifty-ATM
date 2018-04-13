//
//  SearchUsersOptionCell.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 4/7/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class SearchUsersOptionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBOutlet weak var resultsLabel: UILabel!
    
    func updateInfo (info: String){
        self.resultsLabel.text = info
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
