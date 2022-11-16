//
//  SwapTestPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class SwapTestPopup: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    var delegate:SwapTestDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
//        container.layer.cornerRadius = 25
//        yesButton.layer.cornerRadius = 8
//        noButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)


        // Do any additional setup after loading the view.
    }
    @IBAction func yesAction(_ sender: Any) {
        delegate?.swapTestDelegate()
    }
    @IBAction func noAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

protocol SwapTestDelegate {
    func swapTestDelegate()
}
