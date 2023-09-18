//
//  InputCodeController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/16/23.
//

import Foundation
import TangramKit
import MHVerifyCodeView

class InputCodeController: BaseLoginController {
    var pageData: InputCodePageData!
    var codeStyle:Int!
    var codeRequest:CodeRequest!
    
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
        DefaultRepository.shared
            .sendCode(codeStyle, codeRequest)
            .subscribeSuccess {[weak self] data in
                self?.startCountDown()
            }.disposed(by: rx.disposeBag)
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
        codeRequest = CodeRequest()
        if SuperStringUtil.isNotBlank(pageData.phone) {
            target = pageData.phone
            codeStyle = VALUE10
            codeRequest.phone = pageData.phone
        } else {
            target = pageData.email
            codeStyle = VALUE0
            codeRequest.email = pageData.email
        }
        codeSendTargetView.text = R.string.localizable.verificationCodeSentTo(target)
        
        sendCode()
    }
    
    func startCountDown() {
        CountDownUtil.countDown(60) { result in
            if result == 0 {
                self.sendView.setTitle(R.string.localizable.resend(), for: .normal)
                self.sendView.isEnabled = true
            } else {
                self.sendView.setTitle(R.string.localizable.resendCount(result), for: .normal)
            }
            
            self.sendView.sizeToFit()
        }
        
        self.sendView.isEnabled = false
    }
    
    func processNext(_ data:String) {
        if pageData.style == .phoneLogin {
            let param = User()
            param.phone=pageData.phone
            param.email=pageData.email
            param.code=data
            login(param)
        } else {
            codeRequest.code = data

            DefaultRepository.shared
                .checkCode(codeRequest)
                .subscribe({ result in
                    //重设密码
                    SetPasswordController.start(self.navigationController!, self.codeRequest)
                }, { response, error in
                    //清除验证码输入的内容
                    //self.codeInputView.clear
                    return false
                }).disposed(by: rx.disposeBag)
        }
    }
}

extension InputCodeController{
    static func start(_ controller:UINavigationController,_ data:InputCodePageData) {
        let target = InputCodeController()
        target.pageData=data
        controller.pushViewController(target, animated: true)
    }
}
