

import UIKit

class NewTableViewCell: UITableViewCell {
    @IBOutlet weak var BookButton: UIButton!
    @IBOutlet weak var SectionLabel: UILabel!
  
    @IBOutlet weak var shadeView: UIView!
    
    var buttonPressed : (() -> ()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func ButtonClicked(_ sender: Any)
    {
        buttonPressed()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
