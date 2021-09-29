//
//  TokenTableViewCell.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class TokenTableViewCell: UITableViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var step: UILabel!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var estimation: UILabel!
    @IBOutlet weak var statusImage: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var statusImageCenterY: NSLayoutConstraint!
    var startImageStatus :String!
    var delegate:CompleteStepDelegate?
    var indoorMapButtonPressed : (() -> ()) = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        container.createBorderForView(cornerRadius: 5, borderWidth: 0, borderColor: .clear)
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        
        //statusImage.createCircle()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func completeAction(_ sender: UIButton) {
        delegate?.completeStep(index: sender.tag)
    }
    
    @IBAction func indoorClicked(_ sender: Any)
    {
        indoorMapButtonPressed()
    }
}


protocol CompleteStepDelegate {
    func completeStep(index:Int)
}

