//
//  InsuranceTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 28/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class InsuranceTableViewCell: UITableViewCell {
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var validity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateInsuranceDataToUI(){
        name.attributedText = attributeText(string: "Name :Sathishkumar", length: 6)
        providerName.attributedText = attributeText(string: "Provider :United India Insurance", length: 10)
        validity.attributedText = attributeText(string: "Validity :21/01/2020", length: 10)

    }
    
    func attributeText(string:String,length:Int) -> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: string, attributes: [
            .font: UIFont.systemFont(ofSize: 12.0, weight: .regular),
            .foregroundColor: UIColor(red: 154.0 / 255.0, green: 155.0 / 255.0, blue: 171.0 / 255.0, alpha: 1.0),
            .kern: 0.0
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 53.0 / 255.0, green: 54.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0), range: NSRange(location: 0, length: length))
        return attributedString
    }
    
}
