//
//  FilterTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 21/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var selectedType: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
}
