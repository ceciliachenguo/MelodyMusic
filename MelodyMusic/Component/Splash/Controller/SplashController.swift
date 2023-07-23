//
//  ViewController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/22/23.
//

import UIKit
import TangramKit

class SplashController: BaseLogicController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorBackground
        
        self.initRelativeLayoutSafeArea()
        
        //banner
        let bannerView = UIImageView()
        bannerView.tg_width.equal(320)
        bannerView.tg_height.equal(100)
        bannerView.tg_top.equal(220)
        bannerView.tg_centerX.equal(0)
        bannerView.image = R.image.slogan()
        container.addSubview(bannerView)
        
        //copyright
        let copyrightView = UILabel()
        let year = SuperDateUtil.currentYear()
        copyrightView.text = String(format: "Copyright © %d MelodyMusic. All Rights Reserved", year)
        copyrightView.tg_width.equal(.wrap)
        copyrightView.tg_height.equal(.wrap)
        copyrightView.tg_bottom.equal(16)
        copyrightView.tg_centerX.equal(0)
        copyrightView.font = UIFont.systemFont(ofSize: 12)
        copyrightView.textColor = .gray
        container.addSubview(copyrightView)
        
        //logo
        let logoView = UIImageView(image: R.image.logoAndSlogan())
        logoView.tg_width.equal(250)
        logoView.tg_height.equal(31)
        logoView.tg_bottom.equal(copyrightView.tg_top).offset(30)
        logoView.tg_centerX.equal(0)
        logoView.contentMode = .scaleAspectFill
        container.addSubview(logoView)
    }
}


#Preview {
    SplashController()
}
