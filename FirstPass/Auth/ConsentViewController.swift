//
//  ConsentViewController.swift
//  FirstPass
//
//  Created by admin on 14/02/23.
//  Copyright © 2023 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit
import PDFKit

class ConsentViewController: UIViewController {
    @IBOutlet weak var PdfMasterView: UIView!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()
        let pdfView = PDFView()

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        PdfMasterView.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: PdfMasterView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: PdfMasterView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: PdfMasterView.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: PdfMasterView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        guard let path = Bundle.main.url(forResource: "consent", withExtension: "pdf") else { return }

        if let document = PDFDocument(url: path) {
            pdfView.displayMode = .singlePageContinuous
                            pdfView.autoScales = true
                            pdfView.displayDirection = .vertical
            pdfView.document = document
        }
        rejectButton.layer.cornerRadius = 5
        agreeButton.layer.cornerRadius = 5

        rejectButton.layer.borderWidth = 0.5
        rejectButton.layer.borderColor = UIColor.gray.cgColor
    }
    @IBAction func rejectClicked(_ sender: Any)
    {
        presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func agreeClicked(_ sender: Any)
    {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
        self.present(vc, animated: true)
    }
    

}
