//
//  FiltersCollectionViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 17/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class FiltersCollectionViewCell: UICollectionViewCell
{
    var checkButtonPressed : (() -> ()) = {}

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var catgoryLabel: UILabel!
    
    @IBAction func checkClicked(_ sender: Any)
    {
        checkButtonPressed()
    }
}
