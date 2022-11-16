

import UIKit

class SelectAppointmentViewController: UIViewController {

    @IBOutlet weak var SectionLabel: UILabel!
    @IBOutlet weak var time3Label: UILabel!
    @IBOutlet weak var time2Label: UILabel!
    @IBOutlet weak var time1Label: UILabel!
    @IBOutlet weak var date3Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var date1Label: UILabel!
    @IBOutlet weak var dateView3: UIView!
    @IBOutlet weak var dateView2: UIView!
    @IBOutlet weak var dateView1: UIView!
    @IBOutlet weak var timeView3: UIView!
    @IBOutlet weak var timeView2: UIView!
    @IBOutlet weak var timeView1: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imageview2: UIImageView!
    @IBOutlet weak var imageview1: UIImageView!
    
    let blue : UIColor = UIColor( red: 152/255, green: 154/255, blue:255/255, alpha: 1.0 )
    let grey : UIColor = UIColor( red: 209/255, green: 209/255, blue:214/255, alpha: 1.0 )
    
    var Mode = "Video Call"
    var ConsultType = "Tommorow"
    var Time = "12:20 PM"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateView1.layer.cornerRadius = 5
        dateView2.layer.cornerRadius = 5
        dateView3.layer.cornerRadius = 5
        timeView1.layer.cornerRadius = 5
        timeView2.layer.cornerRadius = 5
        timeView3.layer.cornerRadius = 5
        confirmButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.cornerRadius = 10
        
        container.layer.cornerRadius = 30
        
       
        
        
        let date1Gesture = UITapGestureRecognizer(target: self, action: #selector(SelectAppointmentViewController.dateTapped1(gesture:)))
            dateView1.addGestureRecognizer(date1Gesture)
            dateView1.isUserInteractionEnabled = true
        let date2Gesture = UITapGestureRecognizer(target: self, action: #selector(SelectAppointmentViewController.dateTapped2(gesture:)))
            dateView2.addGestureRecognizer(date2Gesture)
            dateView2.isUserInteractionEnabled = true
        let date3Gesture = UITapGestureRecognizer(target: self, action: #selector(SelectAppointmentViewController.dateTapped3(gesture:)))
            dateView3.addGestureRecognizer(date3Gesture)
            dateView3.isUserInteractionEnabled = true
        let time1Gesture = UITapGestureRecognizer(target: self, action: #selector(SelectAppointmentViewController.timeTapped1(gesture:)))
            timeView1.addGestureRecognizer(time1Gesture)
            timeView1.isUserInteractionEnabled = true
        let time2Gesture = UITapGestureRecognizer(target: self, action: #selector(SelectAppointmentViewController.timeTapped2(gesture:)))
            timeView2.addGestureRecognizer(time2Gesture)
            timeView2.isUserInteractionEnabled = true
        let time3Gesture = UITapGestureRecognizer(target: self, action: #selector(SelectAppointmentViewController.timeTapped3(gesture:)))
            timeView3.addGestureRecognizer(time3Gesture)
            timeView3.isUserInteractionEnabled = true
        SectionLabel.text =  UserDefaults.standard.string(forKey: "Section")

    }
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    @objc func dateTapped1(gesture: UIGestureRecognizer)
    {
        //let yourColor : UIColor = UIColor( red: 152/255, green: 154/255, blue:255/255, alpha: 1.0 )
        date1Label.textColor = UIColor.white
        date2Label.textColor = UIColor.black
        date3Label.textColor = UIColor.black
        
        dateView1.layer.backgroundColor = blue.cgColor
        dateView2.layer.backgroundColor = grey.cgColor
        dateView3.layer.backgroundColor = grey.cgColor
        
        ConsultType = "Today"

        
    }
    @objc func dateTapped2(gesture: UIGestureRecognizer)
    {
        date2Label.textColor = UIColor.white
        date1Label.textColor = UIColor.black
        date3Label.textColor = UIColor.black
        
        dateView1.layer.backgroundColor = grey.cgColor
        dateView2.layer.backgroundColor = blue.cgColor
        dateView3.layer.backgroundColor = grey.cgColor
        
        ConsultType = "Tommorow"
    }
    @objc func dateTapped3(gesture: UIGestureRecognizer)
    {
        date3Label.textColor = UIColor.white
        date1Label.textColor = UIColor.black
        date2Label.textColor = UIColor.black
        
        dateView1.layer.backgroundColor = grey.cgColor
        dateView2.layer.backgroundColor = grey.cgColor
        dateView3.layer.backgroundColor = blue.cgColor
        
        ConsultType = "Selected Date"
    }
    @objc func timeTapped1(gesture: UIGestureRecognizer)
    {
        time1Label.textColor = UIColor.white
        time2Label.textColor = UIColor.black
        time3Label.textColor = UIColor.black
        
        timeView1.layer.backgroundColor = blue.cgColor
        timeView2.layer.backgroundColor = grey.cgColor
        timeView3.layer.backgroundColor = grey.cgColor
        
        Time = "09:30 AM"
    }
    @objc func timeTapped2(gesture: UIGestureRecognizer)
    {
        time2Label.textColor = UIColor.white
        time3Label.textColor = UIColor.black
        time1Label.textColor = UIColor.black
        
        timeView1.layer.backgroundColor = grey.cgColor
        timeView2.layer.backgroundColor = blue.cgColor
        timeView3.layer.backgroundColor = grey.cgColor
        
        Time = "12:20 PM"
    }
    @objc func timeTapped3(gesture: UIGestureRecognizer)
    {
        time3Label.textColor = UIColor.white
        time1Label.textColor = UIColor.black
        time2Label.textColor = UIColor.black
        
        timeView1.layer.backgroundColor = grey.cgColor
        timeView2.layer.backgroundColor = grey.cgColor
        timeView3.layer.backgroundColor = blue.cgColor
        
        Time = "04:00 PM"
    }
    @IBAction func RadioButton1_Clicked(_ sender: Any)
    {
            imageview1.image = UIImage(named: "radio-on-button")
            imageview2.image = UIImage(named: "circle")
            Mode = "Video Call"
    }
    
    @IBAction func RadioButton2_Clicked(_ sender: Any)
    {
        imageview2.image = UIImage(named: "radio-on-button")
        imageview1.image = UIImage(named: "circle")
        Mode = "In-Person"
    }
    @IBAction func cancelButtonClicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func confirmButton_Clicked(_ sender: Any)
    {
        UserDefaults.standard.set(Mode, forKey: "Mode")
        UserDefaults.standard.set(ConsultType, forKey: "ConsultType")
        UserDefaults.standard.set(Time, forKey: "Time")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookingConfirmationViewController") as! BookingConfirmationViewController
        present(vc, animated: true, completion: nil)
        
       
        
    }
    @IBAction func BackClicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}
