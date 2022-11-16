//
//  TokenInterfaceController.swift
//  Firstpass-watchOS Extension
//
//  Created by Vinitha on 31/05/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import WatchKit
import Foundation


class TokenInterfaceController: WKInterfaceController {

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

    @IBAction func DismissPressed() {
        presentController(withName: "TokenBeingCalledController", context: nil)
    }
    
}
