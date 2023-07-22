//
//  ViewController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/22/23.
//

import UIKit

//提供类似Android中更高层级的布局框架
import TangramKit

class ViewController: UIViewController {
    var container:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // MARK: - controller
        self.container = TGRelativeLayout()
        
        container.tg_top.equal(TGLayoutPos.tg_safeAreaMargin).offset(16)
        container.tg_leading.equal(TGLayoutPos.tg_safeAreaMargin).offset(16)
        container.tg_trailing.equal(TGLayoutPos.tg_safeAreaMargin).offset(16)
        container.tg_bottom.equal(TGLayoutPos.tg_safeAreaMargin,offset: 16)
        
        view.addSubview(container)
        
        let logoView = UIImageView()
        logoView.image = UIImage(named: "Slogan")
        logoView.tg_width.equal(320)
        logoView.tg_height ~= 120
        logoView.tg_top ~= 100
        logoView.tg_centerX.equal(0)
        container.addSubview(logoView)
        
        // MARK: - bottom container
        let bottomContainer=TGLinearLayout(.vert)
        bottomContainer.tg_width.equal(.fill)
        bottomContainer.tg_height.equal(.wrap)
        bottomContainer.tg_bottom.equal(0)
        bottomContainer.tg_gravity = TGGravity.horz.center
        bottomContainer.tg_space = 30
        container.addSubview(bottomContainer)
        
        // MARK: - phone number login button
        bottomContainer.addSubview(phoneLoginButton)
        
        // MARK: - login button
        bottomContainer.addSubview(primaryButton)
        
        // MARK: - 3rd party login container
        let otherLoginContainer=TGLinearLayout(.horz)
        otherLoginContainer.tg_width.equal(.fill)
        otherLoginContainer.tg_height.equal(.wrap)
        otherLoginContainer.tg_gravity = TGGravity.horz.between
        bottomContainer.addSubview(otherLoginContainer)
        
        //third party login button
        for _ in 0..<4 {
            let buttonView = UIButton(type: .custom)
            buttonView.setImage(UIImage(named: "GoogleIcon"), for: .normal)
//            buttonView.backgroundColor = .green
            buttonView.tg_width.equal(50)
            buttonView.tg_height.equal(50)
            otherLoginContainer.addSubview(buttonView)
        }
        
        // MARK: - user agreement
        let agrementLabelView = UILabel()
        
        agrementLabelView.text = "By continue, you agree to our Terms of Service"
        
        agrementLabelView.font = UIFont.systemFont(ofSize: 12)
        agrementLabelView.textColor = .gray
        agrementLabelView.tg_width.equal(.wrap)
        agrementLabelView.tg_height.equal(.wrap)
        bottomContainer.addSubview(agrementLabelView)
        
        
    }
    
    @objc func phoneLoginClick(_ sender:UIButton) {
        print("ViewController phoneLoginClick \(sender.titleLabel!.text!)")
        
        let t = SettingController()
        navigationController!.pushViewController(t, animated: true)
    }
    
    @objc func primaryClick(_ sender:UIButton) {
        print("ViewController primaryClick \(String(describing: sender.titleLabel?.text))")
    }

    lazy var phoneLoginButton: UIButton = {
        let r = UIButton(type: .system)
        
        r.setTitle("Continue with Phone Number", for: .normal)
        
        r.addTarget(self, action: #selector(phoneLoginClick(_:)), for: .touchUpInside)
        
        r.backgroundColor = UIColor(named: "AccentColor")
        
        r.layer.cornerRadius = 10
        
        r.setTitleColor(.white, for: .normal)
        
        r.setTitleColor(.gray, for: .highlighted)
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(42)
        
        return r
    }()
    
    lazy var primaryButton: UIButton = {
       let r = UIButton(type: .system)
       
       r.setTitle("Continue with username & password", for: .normal)
       
       r.addTarget(self, action: #selector(primaryClick(_:)), for: .touchUpInside)
       
       r.backgroundColor = .clear
       
       r.layer.cornerRadius = 21
       
       r.layer.borderWidth = 1
        r.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
       
       r.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
       
       r.setTitleColor(.gray, for: .highlighted)
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(42)
       
       return r
   }()
}
