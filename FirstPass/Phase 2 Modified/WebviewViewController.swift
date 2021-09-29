//
//  WebviewViewController.swift
//  FirstPass
//
//  Created by Skeintech on 23/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.

import UIKit
import WebKit

class WebviewViewController: UIViewController {
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var HealthTips = false
    var Aboutus = false
    var specialOffers = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if HealthTips
        {
            headingLabel.text = "Health Tips"
            let url = URL(string: Urls.healthTips)!
            let request = URLRequest(url: url)
            webview.load(request)
        }
        else if Aboutus
        {
            headingLabel.text = "About Hospital"
            let url = URL(string: Urls.aboutus)!
            let request = URLRequest(url: url)
            webview.load(request)
        }
        else if specialOffers
        {
            headingLabel.text = "Special Offers"
            let url = URL(string: Urls.specialoffers)!
            let request = URLRequest(url: url)
            webview.load(request)
        }
        
        
        
        
    }
    
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
}
