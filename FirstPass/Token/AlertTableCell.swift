//
//  TokenTableViewCell.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class AlertTableCell: UITableViewCell {
    @IBOutlet weak var container:UIView!
    @IBOutlet weak var notificationMessage:UILabel!
    @IBOutlet weak var notificationTime:UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    var buttonPressed : (() -> ()) = {}

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        container.createBorderForView(cornerRadius: 5, borderWidth: 0, borderColor: .clear)
//        container.layer.masksToBounds = false
//        container.layer.shadowColor = UIColor.black.cgColor
//        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        container.layer.shadowOpacity = 0.2
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func completeAction(_ sender: UIButton) {
       // delegate?.completeStep(index: sender.tag)
    }
    @IBAction func checkboxClicked(_ sender: Any)
    {
        buttonPressed()
    }
    
}





