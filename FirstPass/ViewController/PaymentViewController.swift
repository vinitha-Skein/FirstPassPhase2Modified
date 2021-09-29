

import UIKit

class PaymentViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
    }
    @IBAction func backAction(_ sender: Any)
    {
        //        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "FamilyMemberViewController") as! FamilyMemberViewController
        //        vc.modalPresentationStyle = .fullScreen
        dismiss(animated: true, completion: nil)
        
    }
}
