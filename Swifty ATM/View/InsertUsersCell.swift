//
//  InsertUsersCell.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 4/8/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class InsertUsersCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    
    func updateInfo (info: String){
        self.infoLabel.text = info
    }

}
