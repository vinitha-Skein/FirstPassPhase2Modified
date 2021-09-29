//
//  UpcommingAppointmentsInterfaceController.swift
//  Firstpass-watchOS Extension
//
//  Created by Skeintech on 24/05/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import WatchKit
import Foundation


class UpcommingAppointmentsInterfaceController: WKInterfaceController
{

    @IBOutlet weak var testTable: WKInterfaceTable!
    
    var departments = ["Cardiology","Vitals","Cardiology","Cardiology"]
    var date = ["03.04.2021","04.04.2021","07.04.2021","07.04.2021"]
    var time = ["03:00 PM","11:00 AM","02:00 PM","02:00 PM"]
    
    var indexnumber = UserDefaults.standard.integer(forKey: "index")
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    func tableRefresh()
    {
        testTable.setNumberOfRows(departments.count, withRowType: "UpcommingappointmentsRowController")
       
        for index in 0..<testTable.numberOfRows
        {
            let row = testTable.rowController(at: index) as! UpcommingappointmentsRowController
//            row.ToLabel.setText(toData[index])
//            row.fromLabel.setText(fromData[index])
//            row.flightImageView.setImage(UIImage(named: "travelling"))
            row.dateLabel.setText(date[index])
            row.timeLabel.setText(time[index])
            row.departmentLabel.setText(departments[index])
            row.dateImage.setImage(UIImage(named: "date"))
            row.timeImage.setImage(UIImage(named: "time"))
            if (index == 0)
            {
                if (indexnumber == 1)
                {
                    row.ongoingButton.setHidden(false)
                }
                else
                {
                row.ongoingButton.setHidden(true)
                }
            }
            else
            {
                row.ongoingButton.setHidden(true)

            }
        }
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
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int)
    {
        if(rowIndex == 0)
        {
            if(indexnumber == 1)
            {
            presentController(withName: "CheckinInterfaceController", context: nil)

            }
            else
            {
                presentController(withName: "CheckinPreviewInterfaceController", context: nil)
            }
        }
    }

}
