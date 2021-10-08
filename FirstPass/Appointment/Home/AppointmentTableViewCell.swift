//
//  AppointmentTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 18/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    @IBOutlet var indoorButton: UIButton!
    @IBOutlet var waiTimeLabel: UILabel!
    @IBOutlet var waitLabel: UILabel!
    @IBOutlet var checkinHorizontalLayout: NSLayoutConstraint!
    @IBOutlet weak var appointmentName: UILabel!
//    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var container: UIView!
//    @IBOutlet weak var noteText: UILabel!
    @IBOutlet weak var checkinButton: UIButton!
    @IBOutlet weak var precheckinButton: UIButton!
    //@IBOutlet weak var arrivedButton: UIButton!
//    @IBOutlet weak var parkingButton: UIButton!

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    var delegate:CheckInDelegate?
    var preCheckinButtonPressed : (() -> ()) = {}
    var indoorButtonPressed : (() -> ()) = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.1
        //checkinButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: UIColor(hexString: "#797FDD"))
//        arrivedButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: UIColor(hexString: "#797FDD"))
        //precheckinButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: UIColor(hexString: "#797FDD"))

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateBackgroundColorForIndexPath(_ indexpath: IndexPath) {
        let orange = UIColor(red: 254.0/255.0, green: 164.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        let pink = UIColor(red: 220.0/255.0, green: 79.0/255.0, blue: 137.0/255.0, alpha: 1.0)
        //Applies color to Initial Label
        let colorArray = [orange,pink]
        let randomValue = (indexpath.row + indexpath.section) % colorArray.count
//        colorView.backgroundColor = colorArray[randomValue]
    }
    
    
    func updateBackgroundColorUI(indexPath: IndexPath) {
        updateBackgroundColorForIndexPath(indexPath)
    }
    @IBAction func indoorMapAction(_ sender: UIButton)
    {
//        delegate?.appointmentCheckIn(appointmentIndex: sender.tag)
        indoorButtonPressed()
    }
    
    @IBAction func checkInAction(_ sender: UIButton) {
        delegate?.appointmentCheckIn(appointmentIndex: sender.tag)
        NSLog("Tag------->%d", sender.tag)
    }
    @IBAction func precheckInAction(_ sender: UIButton) {
        //delegate?.appointmentPreCheckIn(appointmentIndex: sender.tag)
        preCheckinButtonPressed()
        
    }
//    @IBAction func arrivedAction(_ sender: UIButton) {
//        delegate?.appointmentArrived(appointmentIndex: sender.tag)
//    }
    @IBAction func parkingAction(_ sender: UIButton) {
        delegate?.appointmentParking(appointmentIndex: sender.tag)
    }
}
