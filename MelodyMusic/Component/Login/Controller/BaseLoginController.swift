//
//  BaseLoginController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import UIKit

class BaseLoginController: BaseTitleController {
    /// 登录
    func login(_ data:User) {
        //推送id
        data.push = "push"
        
        //设备id，就是谁谁的iPhone 这样的名称
        data.device = UIDevice.current.name
        
        DefaultRepository.shared
            .login(data)
            .subscribeSuccess {[weak self] data in
                self?.onLogin(data.data!)
            }.disposed(by: rx.disposeBag)
    }
    
    func onLogin(_ data:Session) {
        //保存登录信息
        PreferenceUtil.setSession(data.session)
        PreferenceUtil.setUserId(data.userId)
        PreferenceUtil.setChatSession(data.chatToken)
        
        AppDelegate.shared.onLogin(data)
    }
}
