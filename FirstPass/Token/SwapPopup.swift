//
//  SwapTestPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class SwapPopup: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var bloodTestButton: UIButton!
    @IBOutlet weak var cathLabButton: UIButton!
     @IBOutlet weak var radiologyButton: UIButton!
    var delegate:swapCathLabDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        container.layer.cornerRadius = 25
        bloodTestButton.layer.cornerRadius = 8
        cathLabButton.layer.cornerRadius = 8
        radiologyButton.layer.cornerRadius = 8
//        noButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)


        // Do any additional setup after loading the view.
    }
    @IBAction func bloodTestButton(_ sender: Any) {
        
        NSLog("Blload TEst")
            dismiss(animated: true, completion: nil)
    }
    @IBAction func cathLabButton(_ sender: Any) {
          NSLog("cath lab TEst")
        delegate?.swapCathLabDelegate()
            dismiss(animated: true, completion: nil)
    }
    @IBAction func radiologyButton(_ sender: Any) {
          NSLog("radio TEst")
        delegate?.swapXrayDelegate()
           dismiss(animated: true, completion: nil)
       }

}

protocol swapCathLabDelegate {
    func swapCathLabDelegate()
      func swapXrayDelegate()
}



