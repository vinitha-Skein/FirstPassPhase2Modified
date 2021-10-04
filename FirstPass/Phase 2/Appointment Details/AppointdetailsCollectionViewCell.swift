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

    @IBOutlet weak var nextStopDepartmentLabel: UILabel!
    @IBOutlet weak var NextStopLabel: UILabel!
    @IBOutlet weak var WaitTimeLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var Container: MyUIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var statusButton: Mybutton!
    @IBAction func indoorMapClicked(_ sender: Any)
    {
        indoorMapButtonPressed()
    }
    @IBAction func statusButton_Clicked(_ sender: Any)
    {
        statusButtonPressed()
    }
    
}
