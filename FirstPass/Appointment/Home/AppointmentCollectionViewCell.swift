//
//  AppointmentCollectionViewCell.swift
//  FirstPass
//
//  Created by Vinitha on 08/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class AppointmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var checkinButton: Mybutton!
    
    @IBOutlet weak var prearrivalButton: Mybutton!
    
    @IBOutlet weak var prefilledLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var indoorMapButton: UIButton!
    
    @IBOutlet weak var prearrivalButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var DetailsView: MyUIView!
    
    @IBOutlet weak var indoorMapDetails: UIButton!
    
    @IBOutlet weak var viewDetailsButton: Mybutton!
}
