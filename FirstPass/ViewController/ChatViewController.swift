
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    

}
