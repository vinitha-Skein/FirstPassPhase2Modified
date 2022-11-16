//
//  FoodandBeveragesTableViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 25/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class FoodandBeveragesTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var itemImage: CustomImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addButton: Mybutton!
    @IBOutlet weak var quantityView: UIView!
    var addClicked:(() -> ())?
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
    @IBAction func decrease_Clciked(_ sender: Any)
    {
        DecreaseClicked!()
    }
    
    @IBAction func add_Clicked(_ sender: Any)
    {
        increaseClicked!()
    }
    @IBAction func AddButton_Clicked(_ sender: Any)
    {
        addClicked!()
    }
}
