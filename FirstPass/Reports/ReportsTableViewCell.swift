//
//  ReportsTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 21/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class ReportsTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    var delegate:ReportDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func viewReportAction(_ sender: UIButton) {
//        delegate?.viewReport(index: sender.tag)
    }
    
}
