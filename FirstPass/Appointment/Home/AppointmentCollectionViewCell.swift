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
    
    @IBOutlet weak var appointmentsView: MyUIView!
    
    @IBOutlet weak var InPatientView: MyUIView!
    
    @IBOutlet weak var viewDetailsInPatientButton: Mybutton!
    
    @IBOutlet weak var appointmentDateCurrent: UILabel!
    
    @IBOutlet weak var doctorNameCurrent: UILabel!
    
    @IBOutlet weak var appointmentTimeCurrent: UILabel!
    
    @IBOutlet weak var patientNameCurrent: UILabel!
    
    
    @IBOutlet weak var waitingTimeCurrent: UILabel!
    
    @IBOutlet weak var TokenNumberCurrent: UILabel!
    
    @IBOutlet weak var TitleCheckedIn: UILabel!
    
    @IBOutlet weak var dateOngoing: UILabel!
    
    @IBOutlet weak var timeOngoing: UILabel!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var currentStepDetails: UILabel!
    
    @IBOutlet weak var counterNumber: UILabel!
    
    @IBOutlet weak var counterNumberLabelActive: UILabel!
    
    @IBOutlet weak var estimatedWaitTimeLabel: UILabel!
}
