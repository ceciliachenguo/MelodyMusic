//
//  UIViewControllerExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import UIKit

extension UIViewController{
    //MARK: - 登录相关
    
    /// 只要用户登录了，才会执行代码块
    func loginAfter(_ data:(()->Void)) {
        if PreferenceUtil.isLogin() {
            data()
        } else {
            toLogin()
        }
    }
    
    /// 启动登录界面
    func toLogin() {
        startController(LoginHomeController.self)
    }
}
