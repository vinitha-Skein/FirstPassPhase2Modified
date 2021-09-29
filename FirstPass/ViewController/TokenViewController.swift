//
//  TokenViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 22/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class TokenViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var scrollviewContainer: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var barcodeImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollviewContainer.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        scrollview.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        scrollviewContainer.layer.masksToBounds = false
        scrollviewContainer.layer.shadowColor = UIColor.black.cgColor
        scrollviewContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        scrollviewContainer.layer.shadowOpacity = 0.2
        barcodeImage.image = generateBarcode(from: "123456789")
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }


}
