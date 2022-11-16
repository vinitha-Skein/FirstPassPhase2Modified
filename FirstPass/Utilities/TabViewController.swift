//
//  TabViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 14/10/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let selectedColor = UIColor.red //UIColor(red: 68.0/255.0, green: 133.0/255.0, blue: 249/255.0, alpha: 1.0)
        let unselectedColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
    }

}
