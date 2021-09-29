//
//  CheckinInterfaceController.swift
//  Firstpass-watchOS Extension
//
//  Created by Skeintech on 26/05/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import WatchKit
import Foundation


class CheckinInterfaceController: WKInterfaceController
{

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

    @IBAction func journeydetails()
    {
        presentController(withName: "JourneyDetailsInterfaceController", context: nil)

    }
    
    @IBAction func currentStepPressed() {
        presentController(withName: "StepsInJourneyInterfaceController", context: nil)
    }
}
