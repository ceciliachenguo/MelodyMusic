//
//  AppDelegate.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/22/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    open class var shared:AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //setting default page
        let controller = SplashController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        
        return true
    }
    
    
    func toGuide() {
        let r = GuideController()
        setRootViewController(r)
    }
    
    // redirect to main page
    func toMain() {
        let r = UINavigationController(rootViewController: MainController())
        setRootViewController(r)
    }
    
    // redirect to Login page
    func toLogin() {
        toMain()
        
        //make sure toMain() finished executing
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(Constants.EVENT_LOGIN_CLICK), object: nil)
        }
    }
    
    func setRootViewController(_ data:UIViewController) {
        window!.rootViewController = data
    }

}
