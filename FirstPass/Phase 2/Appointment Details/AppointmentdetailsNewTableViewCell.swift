//
//  AppointmentdetailsTableViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 18/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class AppointmentdetailsNewTableViewCell: UITableViewCell {

    @IBOutlet weak var WholeContainer: UIView!
    @IBOutlet weak var ServingCounterLabel: UILabel!
    @IBOutlet weak var ServingLabel: UILabel!
    @IBOutlet weak var waitTimesMinsLabel: UILabel!
    @IBOutlet weak var estimatedWaitTimeLabel: UILabel!
    @IBOutlet weak var Container: UIView!
    @IBOutlet var statusButton: UIButton!
    @IBOutlet weak var indoorMapicon: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
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
