//
//  StepsInJourneyInterfaceController.swift
//  Firstpass-watchOS Extension
//
//  Created by Vinitha on 01/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import WatchKit
import Foundation


class StepsInJourneyInterfaceController: WKInterfaceController {
    
    var departments = ["Blood Test","Cardiology","Radiology (Xray)","Pharmacy"]
    var servingLocation = ["Wait time: 05 mins","Wait time: 07 mins","Wait time: 08 mins","Wait time: 15 mins"]
    
    @IBOutlet weak var tableViewSteps: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        tableRefresh()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func tableRefresh()
    {
        tableViewSteps.setNumberOfRows(departments.count, withRowType: "StepsRowController")
        
        for index in 0..<tableViewSteps.numberOfRows
        {
            let row = tableViewSteps.rowController(at: index) as! StepsRowController
            //            row.ToLabel.setText(toData[index])
            //            row.fromLabel.setText(fromData[index])
            //            row.flightImageView.setImage(UIImage(named: "travelling"))
            
            row.titleLabel.setText(departments[index])
            row.waitingTimeLabel.setText(servingLocation[index])
        }
    }
 
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int)
    {
        if(rowIndex == 0)
        {
            presentController(withName: "TokenInterfaceController", context: nil)
        }
        else if rowIndex == 3 {
            presentController(withName: "PhramacyActionView", context: nil)
        }
       
        
    }
    
}
