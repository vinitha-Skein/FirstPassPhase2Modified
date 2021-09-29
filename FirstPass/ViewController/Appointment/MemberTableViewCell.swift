//
//  MemberTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 21/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
}
