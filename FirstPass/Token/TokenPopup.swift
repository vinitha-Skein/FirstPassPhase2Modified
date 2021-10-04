//
//  TokenPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class TokenPopup: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var tokenNumber: UILabel!
    
    @IBOutlet weak var CounterLabel: UILabel!
    var token = ""
    var counter = ""
    
    //var delegate:TokenClosedDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.clear
//        view.isOpaque = false
        container.layer.cornerRadius = 25
        okButton.layer.cornerRadius = 8
//
//        tokenLabel.text = "\(token)"
//        tokenNumber.text = "CRD001"
//        NSLog("token ============> %@",token)
        
//        let attributedString = NSMutableAttributedString(string: token, attributes: [
//            .font: UIFont.systemFont(ofSize: 90.0, weight: .bold),
//            .foregroundColor:UIColor(red: 59.0 / 255.0, green: 182.0 / 255.0, blue: 189.0 / 255.0, alpha: 1.0) ,
//            .kern: 0.0
//        ])
////        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 53.0 / 255.0, green: 56.0 / 255.0, blue: 88.0 / 255.0, alpha: 1.0) , range: NSRange(location: 0, length: 6))
////                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40.0, weight: .semibold), range: NSRange(location: 0, length: 6))
//
//        let attributedString1 = NSMutableAttributedString(string: "CRD001", attributes: [
//                   .font: UIFont.systemFont(ofSize: 30.0, weight: .bold),
//                   .kern: 0.0
//               ])
//        tokenLabel.attributedText = attributedString
//        tokenNumber.attributedText = attributedString1
//        // Do any additional setup after loading the view.
        tokenNumber.text = token
        CounterLabel.text = counter
        
        
    }
    @IBAction func okAction(_ sender: Any) {
       // delegate?.tokenClosed()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeAction(_ sender: Any) {
        //delegate?.tokenClosed()
        dismiss(animated: true, completion: nil)
    }
}



//protocol TokenClosedDelegate {
//    func tokenClosed()
//}
