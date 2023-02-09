//
//  VitalsDoctorTableViewCell.swift
//  FirstPass
//
//  Created by MacOS on 23/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class VitalsDoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var familyRelationLabel: UILabel!
    @IBOutlet weak var doctorImageView: MyImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
