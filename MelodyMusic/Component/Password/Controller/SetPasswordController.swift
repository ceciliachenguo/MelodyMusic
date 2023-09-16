//
//  SetPasswordController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/16/23.
//

import UIKit

class SetPasswordController: BaseLoginController {
    var pageData:CodeRequest!
    private var passwordView:SuperInputView!
    private var confirmPasswordView:SuperInputView!
    
    override func initViews() {
        super.initViews()
        setBackgroundColor(.colorLightWhite)

        title = R.string.localizable.setPassword()

        initLinearLayoutInputSafeArea()

        passwordView = SuperInputView.input(placeholder: R.string.localizable.enterPassword())
            .passwordStyle()
        container.addSubview(passwordView)
        
        confirmPasswordView = SuperInputView.input(placeholder: R.string.localizable.enterConfirmPassword())
            .passwordStyle()
        container.addSubview(confirmPasswordView)
        
        container.addSubview(primaryButton)
    }
    
    @objc func primaryClick(_ sender:QMUIButton) {
        //获取密码
        let password = passwordView.textFieldView.text?.trimmed
        if SuperStringUtil.isBlank(password) {
            SuperToast.show(title: R.string.localizable.enterPassword())
            return
        }

        //判断密码格式
        if !StringUtil.isPassword(password!) {
            SuperToast.show(title: R.string.localizable.errorPasswordFormat())
            return
        }

        //确认获取密码
        let confirmPassword = confirmPasswordView.textFieldView.text?.trimmed
        if SuperStringUtil.isBlank(confirmPassword) {
            SuperToast.show(title: R.string.localizable.enterConfirmPassword())
            return
        }

        //判断确认密码是否一致
        if password != confirmPassword {
            SuperToast.show(title: R.string.localizable.errorConfirmPassword())
            return
        }
        
        let param=User()

        param.phone=pageData.phone
        param.email=pageData.email
        param.code=pageData.code
        param.password=password
        
//        DefaultRepository.shared
//            .resetPassword(param)
//            .subscribeSuccess{ result in
//                self.login(param)
//            }.disposed(by: rx.disposeBag)
    }
    
    lazy var primaryButton: QMUIButton = {
        let r = ViewFactoryUtil.primaryHalfFilletButton()
        r.setTitle(R.string.localizable.setPassword(), for: .normal)
        r.addTarget(self, action: #selector(primaryClick(_:)), for: .touchUpInside)
        return r
    }()
}

extension SetPasswordController{
    static func start(_ controller:UINavigationController,_ data:CodeRequest) {
        let target = SetPasswordController()
        target.pageData=data
        controller.pushViewController(target, animated: true)
    }
}
