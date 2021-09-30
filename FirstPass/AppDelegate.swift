import UIKit
import IQKeyboardManagerSwift
@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    
    //com.skein.Firstpassmodified.watchkitapp.watchkitextension
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 2)
        IQKeyboardManager.shared.enable = true
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "phase2", bundle: nil)
//        let homePage = mainStoryboard.instantiateViewController(withIdentifier: "DischargeViewController") as! DischargeViewController
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
            let homePage = storyboard.instantiateViewController(withIdentifier: "OnBoardViewController") as! OnBoardViewController
            self.window?.rootViewController = homePage

        }
        
//        }
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
}

