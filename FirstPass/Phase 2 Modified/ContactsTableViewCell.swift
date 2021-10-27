//
//  ContactsTableViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 23/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet var branchLabel: UILabel!
    
    
    var MapButtonPressed : (() -> ()) = {}

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func Mapclicked(_ sender: Any) {
        MapButtonPressed()
    }
    
}
