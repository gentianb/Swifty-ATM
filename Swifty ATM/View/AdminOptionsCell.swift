//
//  UserCell.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/20/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class AdminOptionsCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoLabelSub: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateLabel(with name: String, and subName: String)
    {
        infoLabel.text = name
        infoLabelSub.text = subName
        //print("A JENA TU HI QITU O BAB")
    }

}
