//
//  DeleteFamilyMemberViewController.swift
//  FirstPass
//
//  Created by Skeintech on 11/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class DeleteFamilyMemberViewController: UIViewController {

    @IBOutlet var textLabel: UILabel!
    @IBOutlet var headLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var popup_container: UIView!
    var deleteFamilyMember = true
    var contentText = "Are you sure you want to delete this family member?"
    var headText = "Delete family member"
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
deleteButton.layer.cornerRadius = 8
        popup_container.layer.cornerRadius = 10
        container.layer.cornerRadius = 30
        textLabel.text = contentText
        headLabel.text = headText
//         Do any additional setup after loading the view.
    }
    

    @IBAction func back_Pressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func delete_Clicked(_ sender: Any)
    {
        if (deleteFamilyMember == true)
        {
        dismiss(animated: true, completion: nil)
        }
        else
        {
            let storyboard = UIStoryboard(name: "phase2", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MyAppointmentsViewController") as! MyAppointmentsViewController
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }

    }
    
}
