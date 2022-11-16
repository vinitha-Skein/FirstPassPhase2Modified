//
//  WebviewViewController.swift
//  FirstPass
//
//  Created by Skeintech on 23/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.

import UIKit
import WebKit

class WebviewViewController: UIViewController {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var webview: WKWebView!
    
    var HealthTips = false
    var Aboutus = false
    var specialOffers = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if HealthTips
        {
            headingLabel.text = "Health Tips"
//            let url = URL(string: Urls.healthTips)!
//            let request = URLRequest(url: url)
//            webview.load(request)
            let latitude = "25.284903"
            let longitude = "55.321512"
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                 UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
             } else {
                 UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
             }
        }
        else if Aboutus
        {
            headingLabel.text = "About Hospital"
//            let url = URL(string: Urls.aboutus)!
//            let request = URLRequest(url: url)
//            webview.load(request)
            let latitude = "25.284903"
            let longitude = "55.321512"
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                 UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
             } else {
                 UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
             }
        }
        else if specialOffers
        {
            headingLabel.text = "Special Offers"
            let url = URL(string: Urls.specialoffers)!
            let request = URLRequest(url: url)
            webview.load(request)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            vipview()
        }
    }
    func vipview()
    {
        bgView.backgroundColor = .black
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
        headingLabel.textColor = .white
    }
    
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
}
