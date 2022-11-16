//
//  CartTableViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 28/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var ItemNameLabel: UILabel!
    var increaseClicked:(() -> ())?
    var DecreaseClicked:(() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func quantityIncrease_Clicked(_ sender: Any)
    {
        increaseClicked!()
    }
    @IBAction func quantityDecrese_Clicked(_ sender: Any)
    {
        DecreaseClicked!()
    }
    
}
