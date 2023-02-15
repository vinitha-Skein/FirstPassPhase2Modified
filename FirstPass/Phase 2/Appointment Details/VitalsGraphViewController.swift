//
//  VitalsGraphViewController.swift
//  FirstPass
//
//  Created by MacOS on 23/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit
import PDFKit

class VitalsGraphViewController: UIViewController {
    @IBOutlet var currentReadingButton: UIButton!
    
    @IBOutlet var vitalImage2: UIImageView!
    @IBOutlet var vitalImage1: UIImageView!
    @IBOutlet var prevReadingButton: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var PdfMasterView: UIView!

    var name = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        currentReadingButton.titleLabel?.textColor = UIColor(red: 96/255, green: 77/255, blue: 211/255, alpha: 1)
        prevReadingButton.titleLabel?.textColor = UIColor(red: 114/255, green: 127/255, blue: 144/255, alpha: 1)
        
        let pdfView = PDFView()

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
    }
    
    @IBAction func btnCurrentPressed(_ sender: Any)
    {
        currentReadingButton.titleLabel?.textColor = UIColor(red: 96/255, green: 77/255, blue: 211/255, alpha: 1)
        prevReadingButton.titleLabel?.textColor = UIColor(red: 114/255, green: 127/255, blue: 144/255, alpha: 1)
        currentReadingButton.titleLabel?.textColor = UIColor(red: 96/255, green: 77/255, blue: 211/255, alpha: 1)
        vitalImage1.image = UIImage(named: "vitalsPlot1");
       // vitalImage2.image = UIImage(named: "vitalsplot2");
    }
    @IBAction func btnPrevPressed(_ sender: Any)
    {
//        prevReadingButton.setTitleColor(UIColor(red: 96/255, green: 77/255, blue: 211/255, alpha: 1), for: .normal)
//        currentReadingButton.setTitleColor(UIColor(red: 12/255, green: 23/255, blue: 67/255, alpha: 1), for: .normal)
        prevReadingButton.titleLabel?.textColor = UIColor(red: 96/255, green: 77/255, blue: 211/255, alpha: 1)
        currentReadingButton.titleLabel?.textColor = UIColor(red: 114/255, green: 127/255, blue: 144/255, alpha: 1)
        vitalImage1.image = UIImage(named: "vitalsPlot1Prev");
       // vitalImage2.image = UIImage(named: "vitalsPlot2Prev");
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        self.dismiss(animated: true)
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
