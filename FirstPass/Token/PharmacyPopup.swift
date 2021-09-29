//
//  SwapTestPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class PharmacyPopup: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var collectNow: UIButton!
    @IBOutlet weak var nextday: UIButton!
    @IBOutlet weak var courier: UIButton!

   
    var delegate:PharmacyDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                  overrideUserInterfaceStyle = .light
              } 
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        container.layer.cornerRadius = 25
     
        collectNow.layer.cornerRadius = 8
        nextday.layer.cornerRadius = 8
        courier.layer.cornerRadius = 8
//        noButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)


        // Do any additional setup after loading the view.
    }

    @IBAction func NowButton(_ sender: Any) {
         delegate?.pharmacyNowDelegate()
         dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func nextDayButton(_ sender: Any) {
        delegate?.pharmacyNextDayDelegate()
        dismiss(animated: true, completion: nil)

    }
    

    @IBAction func courierButton(_ sender: Any) {
        NSLog("radio TEst")
                  // delegate?.swapXrayDelegate()
                      dismiss(animated: true, completion: nil)
        delegate?.pharmacyCourierDelegate()
    }
  


}

protocol PharmacyDelegate {
    func pharmacyNowDelegate()
    func pharmacyNextDayDelegate()
    func pharmacyCourierDelegate()
}



