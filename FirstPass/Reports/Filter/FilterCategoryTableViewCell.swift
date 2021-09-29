//
//  FilterCategoryTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 10/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FilterCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var selectButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
}
