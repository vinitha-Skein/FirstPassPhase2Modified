//
//  launchScreenInterfaceController.swift
//  Firstpass-watchOS Extension
//
//  Created by Skeintech on 28/05/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import WatchKit
import Foundation


class launchScreenInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            
            self.presentController(withName: "UpcommingAppointmentsInterfaceController", context: nil)
        }

    }
  @objc func  nextpage()
   {
    
   }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
