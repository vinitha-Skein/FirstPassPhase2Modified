//
//  AppointmentHistoryTableViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 24/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class AppointmentHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
