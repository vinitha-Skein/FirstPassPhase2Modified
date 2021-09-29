//
//  ParkingMapPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class ParkingMapPopup: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var parkingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        container.layer.cornerRadius = 25
        okButton.layer.cornerRadius = 8
        cancelButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)
        // Do any additional setup after loading the view.
        
        
         let attributedString = NSMutableAttributedString(string: "Hi Natasha, A parking has been reserved for you in P1-31 for your visit. This is nearest parking to your point of care.", attributes: [
             .font: UIFont.systemFont(ofSize: 15.0, weight: .medium),
             .foregroundColor:UIColor.black ,
             .kern: 0.0
         ])
        attributedString.addAttribute(.foregroundColor, value: UIColor.black , range: NSRange(location: 51, length: 6))
                 attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20.0, weight: .bold), range: NSRange(location: 51, length: 6))
         parkingLabel.attributedText = attributedString
    }
    @IBAction func okAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
