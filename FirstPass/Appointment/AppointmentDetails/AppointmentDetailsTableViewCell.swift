//
//  AppointmentDetailsTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 18/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AppointmentDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateBackgroundColorForIndexPath(_ indexpath: IndexPath) {
        let red = UIColor(red: 255.0/255.0, green: 122.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        let blue = UIColor(red: 122.0/255.0, green: 226.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        let purple = UIColor(red: 177.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let green = UIColor(red: 51.0/255.0, green: 211.0/255.0, blue: 78.0/255.0, alpha: 1.0)
        //Applies color to Initial Label
        let colorArray = [red,blue,purple,green]
        let randomValue = (indexpath.row + indexpath.section) % colorArray.count
        colorView.backgroundColor = colorArray[randomValue]
    }
    
    
    func updateBackgroundColorUI(indexPath: IndexPath) {
        updateBackgroundColorForIndexPath(indexPath)
    }

}
