//
//  AddInsuranceViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 27/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AddInsuranceViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!

    @IBOutlet weak var memberTextfield: UITextField!
    @IBOutlet weak var providerTextfield: UITextField!
    @IBOutlet weak var insuranceNoTextfield: UITextField!
    @IBOutlet weak var validityTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: Any) {
    }
    @IBAction func addImageAction(_ sender: Any) {
    }
    @IBAction func addAction(_ sender: Any) {
    }
    @IBAction func clearAction(_ sender: Any) {
    }
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        addButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        clearButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)
        memberTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        providerTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        insuranceNoTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        validityTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        memberTextfield.addRightView(imageName: "rightView")
        validityTextfield.addRightView(imageName: "rightView")
        memberTextfield.setPlaceholder(placeholderText: "Select policyholder")
        providerTextfield.setPlaceholder(placeholderText: "Enter the name of the insurance provider")
        insuranceNoTextfield.setPlaceholder(placeholderText: "Insurance number")
        validityTextfield.setPlaceholder(placeholderText: "Select insurance validity")

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
