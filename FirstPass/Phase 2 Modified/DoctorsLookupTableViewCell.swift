//
//  DoctorsLookupTableViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 21/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class DoctorsLookupTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var doctorImage: CustomImageView!
    
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func message_Clicked(_ sender: Any)
    {
    }
    @IBAction func call_Clicked(_ sender: Any) {
    }
    @IBAction func videoCall_Clicked(_ sender: Any) {
    }
}
