//
//  ChatwithusTableViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 21/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ChatwithusTableViewCell: UITableViewCell {

   
    @IBOutlet var cellContainer: UIView!
    @IBOutlet var chatViewLeading: NSLayoutConstraint!
    @IBOutlet var chatViewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
