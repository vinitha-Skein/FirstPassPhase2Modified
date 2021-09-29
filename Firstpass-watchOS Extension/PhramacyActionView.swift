//
//  PhramacyActionView.swift
//  Firstpass-watchOS Extension
//
//  Created by Vinitha on 29/05/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import WatchKit
import Foundation


class PhramacyActionView: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func collectNowButtonPressed() {
        let journey = ["Thank you for selecting ‘Now’ Pick.","Please use the same token number to collect your medicines."]
        presentController(withName: "CourierServicesInterfaceController", context: journey)
    }
    
    @IBAction func NextDayPickButtonPressed() {
        let journey = ["Thank you for selecting ‘Next Day’ Pick.","Please use the same token number to collect your medicines."]
        presentController(withName: "CourierServicesInterfaceController", context: journey)
    }
    
    @IBAction func courierButtonPressed() {
        let journey = ["Thank you for selecting ‘Courier’ Services.","Please login to the mobile app and fill the details for courier services."]
        presentController(withName: "CourierServicesInterfaceController", context: journey)
    }
    
}
