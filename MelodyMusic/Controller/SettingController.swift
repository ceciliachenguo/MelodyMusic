//
//  SettingController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/22/23.
//

import UIKit
import TangramKit

class SettingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        
        title = "Setting Page"
        
        let container = TGLinearLayout(.vert)
        container.tg_width.equal(.fill)
        container.tg_height.equal(.wrap)
        container.tg_top.equal(TGLayoutPos.tg_safeAreaMargin).offset(16)
        container.tg_space = 1
        
        container.addSubview(settingView)
        container.addSubview(collectView)
        
        view.addSubview(container)
    }
    
    @objc func onSettingClick(recognizer:UITapGestureRecognizer) {
        print("onSettingClick")
    }
    
    /// 设置Item
    lazy var settingView: SettingView = {
        let r = SettingView()
        
        r.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSettingClick(recognizer:))))
        
        return r
    }()
    
    /// 收藏Item
    lazy var collectView: SettingView = {
        let r = SettingView()
        r.titleView.text = "Collection"
        r.iconView.image = UIImage(systemName: "star")
        r.moreIconView.image = UIImage(systemName: "arrow.right")
        return r
    }()

}
