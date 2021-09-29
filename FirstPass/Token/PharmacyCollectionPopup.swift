//
//  SwapTestPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class PharmacyCollectionPopup: UIViewController {
    
@IBOutlet weak var container: UIView!
@IBOutlet weak var okButton: UIButton!
    
    
    @IBOutlet weak var smilyLogo: UIImageView!
    @IBOutlet weak var collectionThank: UILabel!
    
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var collectionText: UITextView!
    
    var dayCollection : String!
    
    
     var delegate:PharmacyCollectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                  overrideUserInterfaceStyle = .light
              } 
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        container.layer.cornerRadius = 25
        okButton.layer.cornerRadius = 8
//        noButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)


        // Do any additional setup after loading the view.
        
        if dayCollection == "priority"{
         
          
            smilyLogo.image = UIImage(named: "priority")
            collectionThank.text = ""
            collectionTitle.text = "Your token has been upgraded to 'High priority'"
            collectionText.text = "Please be seated in Laboratory waiting area and you will be attended shortly "
            
            
        }else if dayCollection == "now"{
         
          
            smilyLogo.image = UIImage(named: "smily")
            collectionThank.text = "Thank You for selecting"
            collectionTitle.text = "'Now' Pick."
            collectionText.text = "Please use same token number to collect you medicines"
            
            
        } else if dayCollection == "next"{
            let image = UIImage(named: "smily")
           smilyLogo.image = image
            collectionThank.text = "Thank You for selecting"
            collectionTitle.text = "'Next Day' Pick."
            collectionText.text = "Please use same token number to collect you medicines tomorrow"
            
        } else {
            let image = UIImage(named: "van")
                     
                       smilyLogo.image = image
            collectionThank.text = ""
            collectionTitle.text = "Thank you for selection Courier service"
            collectionText.text = "You will be contacted on mobile ending 3090 to arrange for delivery"
        }
        
    }


    @IBAction func okButton(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        
    }
    


}


protocol PharmacyCollectionDelegate {
    func clickOk()

}



