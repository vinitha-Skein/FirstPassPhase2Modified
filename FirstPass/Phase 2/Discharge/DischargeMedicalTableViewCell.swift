//
//  DischargeMedicalTableViewCell.swift
//  FirstPass
//
//  Created by MacOS on 29/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class DischargeMedicalTableViewCell: UITableViewCell {

    @IBOutlet weak var MedicineLabel: UILabel!
    
    @IBOutlet weak var morningLabel: UILabel!
    
    @IBOutlet weak var afternoonLabel: UILabel!
    
    @IBOutlet weak var eveningLabel: UILabel!
    
    
    @IBOutlet weak var NightLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
