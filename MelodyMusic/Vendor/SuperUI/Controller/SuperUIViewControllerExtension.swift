//
//  SuperUIViewControllerExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/5/23.
//

import UIKit

extension UIViewController{
    func getNavigationController() -> UINavigationController {
        var nav = self.navigationController
        if let result = nav {
            return result
        }
        
        let rvc = UIApplication.shared.keyWindow!.rootViewController
        if rvc is UINavigationController {
            nav = rvc as! UINavigationController
        } else {
            nav = rvc!.navigationController
        }
        
        return nav!
    }
    
    func startController(_ data:UIViewController.Type) {
        let target = data.init()
        getNavigationController().pushViewController(target, animated: true)
    }
    
    func startController(_ data:UIViewController) {
        getNavigationController().pushViewController(data, animated: true)
    }
}
