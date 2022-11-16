import UIKit
import IQKeyboardManagerSwift
import Firebase
import AudioToolbox

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    //com.skein.Firstpassmodified.watchkitapp.watchkitextension
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions){ (granted, error) in
               }
        
//        UIApplication.shared.registerForRemoteNotifications()
        
        application.registerForRemoteNotifications()
        Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().delegate = self
        // Override point for customization after application launch.
        
      
        
        Thread.sleep(forTimeInterval: 2)
        IQKeyboardManager.shared.enable = true
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "phase2", bundle: nil)
        UserDefaults.standard.setValue(false, forKey: "vip")
        if UserDefaults.standard.bool(forKey: "OnboardFinished")
        {
            if UserDefaults.standard.bool(forKey: "isLoggedIn")
            {
                print("Inn")
               
                let homePage = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.window?.rootViewController = homePage
            }
            else
            {
                let storyboard:UIStoryboard = UIStoryboard(name: "Modified", bundle: nil)

                let loginPage = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.window?.rootViewController = loginPage
            }
        }
        else
        {
            let storyboard:UIStoryboard = UIStoryboard(name: "Modified", bundle: nil)
            let homePage = storyboard.instantiateViewController(withIdentifier: "OnBoardViewController") as! OnBoardViewController
            self.window?.rootViewController = homePage

        }
        return true
    }
    
    
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
        
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        debugPrint("FCM Token - \(String(describing: fcmToken))")
        guard let fcmToken = Messaging.messaging().fcmToken else {
            return
        }
        
        UserDefaults.standard.setValue(fcmToken, forKey: "FCM_REGITERED_TOKEN")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    //MARK:- UNUserNotification Delegates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
        print(notification.request)
        debugPrint(notification.request.content.title)
        UIDevice.vibrate()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("NotificationText").setValue(["Notification": "\(notification.request.content.body)"])
        if notification.request.content.body.contains("is called for")
        {
            let fullNotificationString = notification.request.content.body
            let fullNameArr = fullNotificationString.components(separatedBy: "your token number ")
            debugPrint(fullNameArr[0])
            let tokenSeperation = fullNameArr[1].components(separatedBy: " ")
            debugPrint(tokenSeperation[0])
            let counterNumberArray = fullNotificationString.components(separatedBy: ":")
            debugPrint(counterNumberArray[1])
            showTokenPopup(token: tokenSeperation[0], Counter: counterNumberArray[1])
            
        }
        else if notification.request.content.body.contains("is ended for")
        {
            let fullNotificationString = notification.request.content.body
            let fullNameArr = fullNotificationString.components(separatedBy: "is ended for ")
            debugPrint(fullNameArr[0])
            let departmentSepaeration = fullNameArr[1].components(separatedBy: " ")
            debugPrint(departmentSepaeration[0])
            let fullTokenArr = fullNotificationString.components(separatedBy: "your token number ")
            debugPrint(fullTokenArr[0])
            let tokenSeperation = fullTokenArr[1].components(separatedBy: " ")
            debugPrint(tokenSeperation[0])
            NotificationCenter.default.post(name: Notification.Name("HomeAppointmentRefreshNotification"), object: nil, userInfo: ["department":"\(departmentSepaeration[0])","Token":"\(tokenSeperation[0])"])
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        debugPrint(response.actionIdentifier)
        print(response.notification.request.content.title)
        print(response.notification.request.content.body)
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
    
//    func  showTokenPopup(token:String,Counter:String)
//    {
//        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
//        vc.modalPresentationStyle = .fullScreen
//        vc.token = token
//        vc.counter = Counter
//        //self.window?.rootViewController?.present(vc, animated: true, completion: nil)
//
//    }
    
    
    func  showTokenPopup(token:String,Counter:String)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
            vc.modalPresentationStyle = .fullScreen
            vc.token = token
            vc.counter = Counter
            DispatchQueue.main.async { [self] in
                getTopMostViewController()?.present(vc, animated: true, completion: nil)
            }
        }
        func getTopMostViewController() -> UIViewController? {
            var topMostViewController = UIApplication.shared.keyWindow?.rootViewController

            while let presentedViewController = topMostViewController?.presentedViewController {
                topMostViewController = presentedViewController
            }

            return topMostViewController
        }
}




