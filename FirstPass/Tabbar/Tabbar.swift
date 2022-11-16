//
//  Tabbar.swift
//  FirstPass
//
//  Created by Vinitha on 07/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import Foundation
import UIKit

protocol BottomViewDelegate
{
    func AccountsClicked()
    func AppointmentsClicked()
    func VideCallClicked()
}

class Tabbar: UIView {
    private let nibName = "Tabbar"
    
    @IBOutlet weak var appointmentLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var videoCallView: MyUIView!
    @IBOutlet var Container: UIView!
    @IBOutlet weak var bottomView: MyUIView!
    
    @IBOutlet weak var centerView: MyUIView!
    
    @IBOutlet weak var appointmentView: UIView!
    
    @IBOutlet var tabbarImages: [UIImageView]!
    
    @IBOutlet var tabbartitleLabels: [UILabel]!
    
    var delegate: BottomViewDelegate?

    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        commonInit(nibName)
       
        if Constants.selectedMenu == 0 {
            tabbarImages[0].image = UIImage(named: "appointment_select")
            tabbarImages[1].image = UIImage(named: "account")
            
        }
        else if Constants.selectedMenu == 2 {
            tabbarImages[0].image = UIImage(named: "appointment")
            tabbarImages[1].image = UIImage(named: "account_select")
        }
        if UserDefaults.standard.bool(forKey: "vip")
        {
//            Container.backgroundColor = UIColor(hex: "#14181A")
            bottomView.backgroundColor = UIColor(hex: "#222629")
            videoCallView.backgroundColor = UIColor(named: "vip")
            appointmentLabel.textColor = UIColor.white
            accountLabel.textColor = UIColor.white
            tabbarImages[0].image = UIImage(named: "appointmentvip")
            tabbarImages[1].image = UIImage(named: "accountvip")
        }
        
        
    }
    
    
    @IBAction func tabbarButtonsPressed(_ sender: UIButton)
    {
        if (sender.tag == 2)
        {
            self.delegate?.AccountsClicked()
        }
        else if (sender.tag == 0)
        {
            self.delegate?.AppointmentsClicked()
        } else if (sender.tag == 1) {
            self.delegate?.VideCallClicked()
        }
    }
    
}

