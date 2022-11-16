//
//  CourierServicesInterfaceController.swift
//  Firstpass-watchOS Extension
//
//  Created by Vinitha on 31/05/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import WatchKit
import Foundation


class CourierServicesInterfaceController: WKInterfaceController {

    @IBOutlet weak var thankYouLAbel: WKInterfaceLabel!
    
    @IBOutlet weak var pleaseLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let values = context as? [Any] else { return }
        let context = values[0]
        thankYouLAbel.setText(values[0] as? String)
        pleaseLabel.setText(values[1] as? String)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
