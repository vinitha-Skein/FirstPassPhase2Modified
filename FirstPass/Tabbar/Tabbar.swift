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
}

class Tabbar: UIView {
    private let nibName = "Tabbar"
    
    @IBOutlet weak var bottomView: MyUIView!
    
    @IBOutlet weak var centerView: MyUIView!
    
    @IBOutlet weak var appointmentView: UIView!
    
    @IBOutlet var tabbarImages: [UIImageView]!
    
    @IBOutlet var tabbartitleLabels: [UILabel]!
    
    var delegate: BottomViewDelegate?

    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit(nibName)
       
        if Constants.selectedMenu == 0 {
            tabbarImages[0].image = UIImage(named: "appointment_select")
            tabbarImages[1].image = UIImage(named: "account")
            
        } else if Constants.selectedMenu == 2 {
            tabbarImages[0].image = UIImage(named: "appointment")
            tabbarImages[1].image = UIImage(named: "account_select")
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
        }
    }
    
}

