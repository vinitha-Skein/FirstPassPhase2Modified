//
//  NewBillingPaymentViewController.swift
//  FirstPass
//
//  Created by MacOS on 23/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class NewBillingPaymentViewController: UIViewController
{

    @IBOutlet weak var confirmationView: UIView!
    
    @IBOutlet weak var successPaymentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func paymentOptionPressed(_ sender: Any) {
        confirmationView.isHidden = false
    }
    
    @IBAction func paymentConfirmPressed(_ sender: Any) {
        confirmationView.isHidden = true
        successPaymentView.isHidden = false
    }
    
    @IBAction func paymentCancelPressed(_ sender: Any) {
       // self.dismiss(animated: true)
        confirmationView.isHidden = true
    }
    
    @IBAction func downloadInvoicePressed(_ sender: Any) {
        do {
        let stuffFileURL = try makeWritableCopy(named: "Lab_Report.pdf", ofResourceFile: "Lab_Report.pdf")
        try "New contents".write(to: stuffFileURL, atomically: true, encoding: String.Encoding.utf8)
        }
        catch {
           print(error.localizedDescription)
       }
        self.dismiss(animated: true)
    }
    
 
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func makeWritableCopy(named destFileName: String, ofResourceFile originalFileName: String) throws -> URL {
        // Get Documents directory in app bundle
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("No document directory found in application bundle.")
        }

        // Get URL for dest file (in Documents directory)
        let writableFileURL = documentsDirectory.appendingPathComponent(destFileName)

        // If dest file doesn’t exist yet
        if (try? writableFileURL.checkResourceIsReachable()) == nil {
            // Get original (unwritable) file’s URL
            guard let originalFileURL = Bundle.main.url(forResource: originalFileName, withExtension: nil) else {
                fatalError("Cannot find original file “\(originalFileName)” in application bundle’s resources.")
            }

            // Get original file’s contents
            let originalContents = try Data(contentsOf: originalFileURL)

            // Write original file’s contents to dest file
            try originalContents.write(to: writableFileURL, options: .atomic)
            print("Made a writable copy of file “\(originalFileName)” in “\(documentsDirectory)\\\(destFileName)”.")

        } else { // Dest file already exists
            // Print dest file contents
            let contents = try String(contentsOf: writableFileURL, encoding: String.Encoding.utf8)
            print("File “\(destFileName)” already exists in “\(documentsDirectory)”.\nContents:\n\(contents)")
        }

        // Return dest file URL
        return writableFileURL
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
