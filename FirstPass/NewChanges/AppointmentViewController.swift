
import UIKit

class AppointmentViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.lightGray.cgColor

    }
    var menuItems = ["Tele Consultation","Cardiology","Dermatology","Dentistry","Family Medicine","Nephrology"]

    @IBAction func backClicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
}
extension AppointmentViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell") as! NewTableViewCell
        cell.SectionLabel.text = menuItems[indexPath.row]
        cell.BookButton.layer.cornerRadius = 5
        cell.shadeView.layer.cornerRadius = 10
        cell.buttonPressed =
            {
                if(indexPath.row == 0)
                {
                    UserDefaults.standard.set("Tele Consultation - Dr John", forKey: "Section")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SelectAppointmentViewController") as! SelectAppointmentViewController
                    self.present(vc, animated: true, completion: nil)
                    
                   
                }
                else if (indexPath.row == 1)
                {
                    UserDefaults.standard.set("Cardiology - Dr John", forKey: "Section")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SelectAppointmentViewController") as! SelectAppointmentViewController
                    self.present(vc, animated: true, completion: nil)
                    
                    
                }
                else if (indexPath.row == 2)
                {
                    UserDefaults.standard.set("Dermatology - Dr John", forKey: "Section")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SelectAppointmentViewController") as! SelectAppointmentViewController
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else if (indexPath.row == 3)
                {
                    UserDefaults.standard.set("Dentistry - Dr John", forKey: "Section")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SelectAppointmentViewController") as! SelectAppointmentViewController
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else if (indexPath.row == 4)
                {
                    UserDefaults.standard.set("Family Medicine - Dr John", forKey: "Section")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SelectAppointmentViewController") as! SelectAppointmentViewController
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else if (indexPath.row == 5)
                {
                    UserDefaults.standard.set("Nephrology - Dr John", forKey: "Section")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SelectAppointmentViewController") as! SelectAppointmentViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuItems.count
    }
}
