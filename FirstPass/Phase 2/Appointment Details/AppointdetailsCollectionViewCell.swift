//
//  AppointdetailsCollectionViewCell.swift
//  FirstPass
//
//  Created by Skeintech on 18/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class AppointdetailsCollectionViewCell: UICollectionViewCell
{
    
    var indoorMapButtonPressed : (() -> ()) = {}
    var statusButtonPressed : (() -> ()) = {}


    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var statusButton: Mybutton!
    @IBOutlet weak var indexLabel: UILabel!
    @IBAction func indoorMapClicked(_ sender: Any)
    {
        indoorMapButtonPressed()
    }
    @IBAction func statusButton_Clicked(_ sender: Any)
    {
        statusButtonPressed()
    }
    
}
