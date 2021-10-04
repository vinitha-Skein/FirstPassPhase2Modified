import UIKit
import IQKeyboardManagerSwift
import Firebase

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    //com.skein.Firstpassmodified.watchkitapp.watchkitextension
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 2)
        IQKeyboardManager.shared.enable = true
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "phase2", bundle: nil)
//        let homePage = mainStoryboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
//        self.window?.rootViewController = homePage

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
            let homePage = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
            self.window?.rootViewController = homePage

        }
        
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions){ (granted, error) in
               }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        application.registerForRemoteNotifications()
        Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().delegate = self
    
//        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let homePage = mainStoryboard.instantiateViewController(withIdentifier: "InsuranceViewController") as! InsuranceViewController
//            self.window?.rootViewController = homePage
//        let memoryCapacity = 500 * 1024 * 1024
//        let diskCapacity = 500 * 1024 * 1024
//        let urlCache = URLCache(memoryCapacity: memoryCapacity,
//        diskCapacity: diskCapacity,
//        diskPath: "myCachePath")
//        URLCache.shared = urlCache
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
    //MARK:- UNUserNotification Delegates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        debugPrint(response.actionIdentifier)
        print(response.notification.request.content.title)
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
    
}

