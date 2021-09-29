//
//  FeedbackNotificationViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 03/12/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FeedbackNotificationViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var okButton: UIButton!
    var delegate:FeedbackNotificationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        okButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)

    }
    @IBAction func okAction(_ sender: Any) {
        delegate?.feedbackOKAction()
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


protocol FeedbackNotificationDelegate {
    func feedbackOKAction()
}
