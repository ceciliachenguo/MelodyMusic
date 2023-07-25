//
//  SuperToast.swift
//  Pop-up Toast Shape Warning
//
//  Created by Cecilia Chen on 7/25/23.
//

import UIKit

class SuperToast {
    
    static var hud:MBProgressHUD?
    
    static func show(title:String) {
        let hud = MBProgressHUD.showAdded(to: AppDelegate.shared.window!.rootViewController!.view, animated: true)
        hud.mode = .text
        
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = .black
        
        hud.label.textColor = .colorLightWhite
        hud.label.font = UIFont.boldSystemFont(ofSize: 16)
        hud.label.numberOfLines = 0
        
        hud.label.text = title
        
        let offsetY = -hud.frame.height/CGFloat(2)+80
        
        //present at the top of the screen
        hud.offset = CGPoint(x: 0, y: offsetY)

        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1.5)
    }

    //indication for loading
    static func showLoading(title:String = R.string.localizable.superLoading()){
        
        //change progress icon color if activity indicator created inside MBProgressHUD
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = .white
        
        if SuperToast.hud == nil {
            SuperToast.hud = MBProgressHUD.showAdded(to: AppDelegate.shared.window!.rootViewController!.view, animated: true)
            //progress
            SuperToast.hud!.mode = .indeterminate
            SuperToast.hud!.minSize = CGSize(width: 120, height: 120)
            
            //background semi-transparent
            SuperToast.hud!.backgroundView.style = .solidColor
            SuperToast.hud!.backgroundView.color = UIColor(white: 0, alpha: 0.5)
            
            //background color
            SuperToast.hud!.bezelView.style = .solidColor
            SuperToast.hud!.bezelView.backgroundColor = .black
            
            //title text color
            SuperToast.hud!.label.textColor = .colorLightWhite
            SuperToast.hud!.label.font = UIFont.boldSystemFont(ofSize: TEXT_LARGE)
            
            //Show
            SuperToast.hud!.show(animated: true)
        }
        SuperToast.hud!.label.text = title
        //Can also set sub title
    }
    
    static func hideLoading() {
        if let r = SuperToast.hud {
            r.hide(animated: true)
            SuperToast.hud = nil
        }
    }
}
