//
//  JourneyDetailsInterfaceController.swift
//  WatchTestApp Extension
//
//  Created by Skeintech on 27/05/21.
//

import WatchKit
import Foundation


class JourneyDetailsInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    var departments = ["Registration","Vitals","Cardiology","Blood Test","Pharmacy"]
    var servingLocation = ["CounterNo. 05","Room No. 11","Room No. 05","Room No. 05","Room No. 12"]

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
        table.setNumberOfRows(departments.count, withRowType: "JourneyRowController")
       
        for index in 0..<table.numberOfRows
        {
            let row = table.rowController(at: index) as! JourneyRowController
//            row.ToLabel.setText(toData[index])
//            row.fromLabel.setText(fromData[index])
//            row.flightImageView.setImage(UIImage(named: "travelling"))
            
            row.departmentLabel.setText(departments[index])
            row.servingLocationLabel.setText(servingLocation[index])

            if (index == 0)
            {
                row.ongoingButton.setHidden(false)
            }
            else
            {
                row.ongoingButton.setHidden(true)

            }
        }
    }
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int)
    {
        if(rowIndex == 0)
        {
            presentController(withName: "TokenController", context: nil)
        }
        else
        {
            presentController(withName: "NoAppointment", context: nil)

        }

    }

}
