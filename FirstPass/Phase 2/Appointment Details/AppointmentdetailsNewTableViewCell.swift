//
//  AppointmentdetailsTableViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 18/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class AppointmentdetailsNewTableViewCell: UITableViewCell {

    @IBOutlet var statusButton: UIButton!
    @IBOutlet weak var indoorMapicon: UIButton!
    @IBOutlet weak var servingLabel: UILabel!
    @IBOutlet weak var timeHeadLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var servingCounterLabel: UILabel!
    @IBOutlet weak var estimatedWaittimeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    var indoorMapButtonPressed : (() -> ()) = {}
    var statusButtonPressed : (() -> ()) = {}


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func status_Clicked(_ sender: Any)
    {
        statusButtonPressed()
    }
    
    @IBAction func indoorClicked(_ sender: Any)
    {
        indoorMapButtonPressed()
    }
}
