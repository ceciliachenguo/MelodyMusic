//
//  AppDelegate.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/22/23.
//

import UIKit
import SwiftEventBus

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    open class var shared:AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initMMKV()
        
        // Override point for customization after application launch.
        //setting default page
        let controller = SplashController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        
        if PreferenceUtil.isLogin() {
            onLogin(nil)
        }
        
        return true
    }
    
    func initMMKV() {
        MMKV.initialize(rootDir: nil)
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
    
    func logout() {
        logoutSilence()
    }
    
    func logoutSilence() {
        //清除登录相关信息
        PreferenceUtil.logout()
        
        loginStatusChanged()
    }
    
    func onLogin(_ d:Session?) {
        var data:Session!
        if d==nil {
            data = Session()
            data!.userId = PreferenceUtil.getUserId()
            data!.session = PreferenceUtil.getSession()
            data!.chatToken = PreferenceUtil.getChatSession()
        }else{
            data=d
        }
        
        if let navigationController = window?.rootViewController as? UINavigationController {
            //关闭登陆相关界面
            let vcs = navigationController.viewControllers
            
            var results:[UIViewController] = []
            for it in vcs {
                if it is LoginHomeController ||
                it is RegisterController ||
                it is LoginController {
                    continue
                }
                
                results.append(it)
            }
            
            navigationController.setViewControllers(results, animated: true)
        }
        
        loginStatusChanged()

    }
    
    func loginStatusChanged() {
        SwiftEventBus.post(Constants.EVELT_LOGIN_STATUS_CHANGED)
    }
    
    func setRootViewController(_ data:UIViewController) {
        window!.rootViewController = data
    }

}

