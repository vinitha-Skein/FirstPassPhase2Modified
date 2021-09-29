import UIKit
import MapwizeUI
import CoreLocation
import Mapbox

class IndoorMapViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var MWZmapview: MWZUIView!
    //var mapwizeView: MWZUIView!
    let manager = CLLocationManager()
    let currentposition = ILIndoorLocationProvider()
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //currentposition?.start()
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        activityindicator.hidesWhenStopped = true
        activityindicator.startAnimating()
        }

    override func viewDidAppear(_ animated: Bool)
    {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
              let   opts = MWZUIOptions()
                    opts.mainColor = .orange
                    opts.centerOnVenueId = "60043de35696e90016309457"
                    let settings = MWZUISettings()

        MWZmapview = MWZUIView(frame: self.MWZmapview.frame, mapwizeOptions: opts, uiSettings: settings)
//              mapwizeView = MWZUIView(frame: <#T##CGRect#>, mapwizeOptions: <#T##MWZUIOptions#>, uiSettings: <#T##MWZUISettings#>)

                    MWZmapview.translatesAutoresizingMaskIntoConstraints = true
                    MWZmapview?.delegate = self
                    self.view.addSubview(MWZmapview!)
//
//        NSLayoutConstraint.init(item: MWZmapview!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant:100.0).isActive = true
//        NSLayoutConstraint.init(item: MWZmapview!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 20.0).isActive = true
//        NSLayoutConstraint.init(item: MWZmapview!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 50.0).isActive = true
//        NSLayoutConstraint.init(item: MWZmapview!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 20.0).isActive = true
        activityIndicatorView.isHidden = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.first
        else
        {
            print("Location Not Available")
            return
        };

        let cordinate = location.coordinate
        let marker = MWZMarker()

    }
    @IBAction func backAction(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}
extension IndoorMapViewController: MWZUIViewDelegate,ILIndoorLocationProviderDelegate
{
    func provider(_ provider: ILIndoorLocationProvider!, didUpdate location: ILIndoorLocation!)
    {
        print(location)
        let userLoction = ILIndoorLocation()
        print(userLoction.latitude)
        print(userLoction.longitude)
    }
    func provider(_ provider: ILIndoorLocationProvider!, didFailWithError error: Error!)
    {

    }

    func providerDidStart(_ provider: ILIndoorLocationProvider!) {

    }

    func providerDidStop(_ provider: ILIndoorLocationProvider!) {

    }
    func setIndoorLocationProvider(_ locationProvider: ILIndoorLocationProvider?)
    {

    }

    func mapwizeView(_ mapwizeView: MWZUIView, didSelect place: MWZPlace, currentUniverse: MWZUniverse, searchResultUniverse: MWZUniverse, channel: MWZUIEventChannel, searchQuery: String?)
    {

    }
    func mapwizeView(_ mapwizeView: MWZUIView, didSelect placelist: MWZPlacelist, currentUniverse: MWZUniverse, searchResultUniverse: MWZUniverse, channel: MWZUIEventChannel, searchQuery: String?)
    {

    }

    func mapwizeViewDidLoad(_ mapwizeView: MWZUIView)
    {

    }
    func mapwizeViewDidTap(onFollowWithoutLocation mapwizeView: MWZUIView)
    {
        //let userLoction = ILIndoorLocation()
        //print(userLoction.latitude)
        //print(userLoction.longitude)
        print("onFollowWithoutLocation")

        let alert = UIAlertController.init(title: "Sorry!",
                                           message: "GPS is not Available right Now.",
                                           preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func mapwizeViewDidTap(onMenu mapwizeView: MWZUIView) {
        print("onMenu")
        let alert = UIAlertController.init(title: "User action",
                                           message: "Click on the menu",
                                           preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func mapwizeView(_ mapwizeView: MWZUIView, didTapOnPlaceInformationButton place: MWZPlace)
    {
        print("didTapOnPlaceInformationButton")
        let message = "Click on the place information button \(place.translations[0].title)"
        let alert = UIAlertController.init(title: "User action",
                                           message: message,
                                           preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func mapwizeView(_ mapwizeView: MWZUIView, didTapOnPlacelistInformationButton placeList: MWZPlacelist)
    {
        print("didTapOnPlaceListInformationButton")
        let message = "Click on the placelist information button \(placeList.translations[0].title)"
        let alert = UIAlertController.init(title: "User action",
                                           message: message,
                                           preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func mapwizeView(_ mapwizeView: MWZUIView, shouldShowInformationButtonFor mapwizeObject: MWZObject) -> Bool
    {
        return false
    }

    func mapwizeView(_ mapwizeView: MWZUIView, shouldShowFloorControllerFor floors: [MWZFloor]) -> Bool
    {
        if (floors.count > 1) {
            return true
        }
        return false
    }
}
