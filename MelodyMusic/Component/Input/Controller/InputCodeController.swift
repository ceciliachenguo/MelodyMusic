//
//  InputCodeController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/16/23.
//

import Foundation
import TangramKit
import MHVerifyCodeView

class InputCodeController: BaseTitleController {
    var pageData: InputCodePageData!
    
    override func initViews() {
        super.initViews()
        setBackgroundColor(.colorLightWhite)
        
        initLinearLayoutInputSafeArea()
        
        container.tg_padding = UIEdgeInsets(top: PADDING_LARGE2, left: PADDING_LARGE2, bottom: PADDING_LARGE2, right: PADDING_LARGE2)
        
        container.tg_gravity = TGGravity.horz.right
        
        let inputTitleView = UILabel()
        inputTitleView.tg_width.equal(.fill)
        inputTitleView.tg_height.equal(.wrap)
        inputTitleView.text=R.string.localizable.verificationCode()
        inputTitleView.font = UIFont.systemFont(ofSize: TEXT_LARGE4)
        inputTitleView.textColor = .colorOnSurface
        container.addSubview(inputTitleView)
        
        container.addSubview(codeSendTargetView)
        
        container.addSubview(codeInputView)
        
        //resend button
        container.addSubview(sendView)
    }

    lazy var sendView: QMUIButton = {
        let r = ViewFactoryUtil.linkButton()
        r.setTitleColor(.black80, for: .normal)
        r.addTarget(self, action: #selector(sendClick(_:)), for: .touchUpInside)
        r.setTitle(R.string.localizable.resend(), for: .normal)
        r.sizeToFit()
        return r
    }()
    
    @objc func sendClick(_ sender:QMUIButton) {
        sendCode()
    }
    
    func sendCode() {
//        DefaultRepository.shared
//            .sendCode(codeStyle, codeRequest)
//            .subscribeSuccess {[weak self] data in
//                //发送成功了
//
//                //开始倒计时
//                self?.startCountDown()
//            }.disposed(by: rx.disposeBag)
    }
    
    lazy var codeSendTargetView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.textColor = .colorOnSurface
        
        return r
    }()
    
    lazy var codeInputView: MHVerifyCodeView = {
        let r = MHVerifyCodeView.init()
        r.tg_width.equal(.fill)
        r.tg_height.equal(50)
        r.spacing = 10
        r.verifyCount = 6
        r.setCompleteHandler { (result) in
            self.processNext(result)
        }
        return r
    }()
    
    override func initDatum() {
        super.initDatum()
        //显示验证码发送到目标
        var target:String!
        if SuperStringUtil.isNotBlank(pageData.phone) {
            target = pageData.phone
        } else {
            target = pageData.email
        }
        codeSendTargetView.text = R.string.localizable.verificationCodeSentTo(target)
        
        sendCode()
    }
    
    func processNext(_ data:String) {
//        if pageData.style == .phoneLogin {
//            //手机号验证码登录
//            let param = User()
//            param.phone=pageData.phone
//            param.email=pageData.email
//            param.code=data
//            login(param)
//        } else {
//            //先校验验证码
//            codeRequest.code = data
//
//            DefaultRepository.shared
//                .checkCode(codeRequest)
//                .subscribe({ result in
//                    //重设密码
//                    SetPasswordController.start(self.navigationController!, self.codeRequest)
//                }, { response, error in
//                    //清除验证码输入的内容
//                    //self.codeInputView.clear
//                    return false
//                }).disposed(by: rx.disposeBag)
//        }
    }
}

extension InputCodeController{
    static func start(_ controller:UINavigationController,_ data:InputCodePageData) {
        let target = InputCodeController()
        target.pageData=data
        controller.pushViewController(target, animated: true)
    }
}
