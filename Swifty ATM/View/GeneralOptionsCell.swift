//
//  GeneralOptionsCell.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/27/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class GeneralOptionsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var infoLabel: UILabel!
    
    func updateInfo (info: String){
        self.infoLabel.text = info
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
