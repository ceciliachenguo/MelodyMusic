//
//  TermServiceDialogController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/23/23.
//

import UIKit
import TangramKit

class TermServiceDialogController: BaseController, QMUIModalPresentationContentViewControllerProtocol {
    
    var contentContainer: TGBaseLayout!
    var modalController: QMUIModalPresentationViewController!
    var textView: UITextView!
    var disagreeButton:QMUIButton!

    override func initViews() {
        super.initViews()
        view.layer.cornerRadius = MEDIUM_RADIUS
        view.clipsToBounds = true
        view.backgroundColor = .colorDivider
        view.tg_width.equal(.fill)
        view.tg_height.equal(.wrap)
        
        //content container
        contentContainer = TGLinearLayout(.vert)
        contentContainer.tg_width.equal(.fill)
        contentContainer.tg_height.equal(.wrap)
        contentContainer.tg_space = 25
        contentContainer.backgroundColor = .colorBackground
        contentContainer.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
        contentContainer.tg_gravity = TGGravity.horz.center
        view.addSubview(contentContainer)
        
        contentContainer.addSubview(titleView)
        
        textView = UITextView()
        textView.tg_width.equal(.fill)
        textView.tg_height.equal(230)
        textView.text = "This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use. This is terms of Use."
        textView.backgroundColor = .clear
        textView.isEditable = false
        contentContainer.addSubview(textView)
        contentContainer.addSubview(primaryButton)
        
        disagreeButton = ViewFactoryUtil.linkButton()
        disagreeButton.setTitle(R.string.localizable.disagree(), for: .normal)
        disagreeButton.setTitleColor(.black80, for: .normal)
        disagreeButton.addTarget(self, action: #selector(disagreeClick(_:)), for: .touchUpInside)
        disagreeButton.sizeToFit()
        contentContainer.addSubview(disagreeButton)
    }
    
    @objc func disagreeClick(_ sender:QMUIButton) {
        hide()
        
        //Exit the APP
        exit(0)
    }
    
    func show() {
        modalController = QMUIModalPresentationViewController()
        modalController.animationStyle = .fade
        
        modalController.contentViewMargins = UIEdgeInsets(top: PADDING_LARGE2, left: PADDING_LARGE2, bottom: PADDING_LARGE2, right: PADDING_LARGE2)
        
        //diable user to click outside the box to hide the pop-up window
        modalController.isModal = true
        modalController.contentViewController = self
        modalController.showWith(animated: true)
    }
    
    func hide() {
        modalController.hideWith(animated: true, completion: nil)
    }
    
    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.text = R.string.localizable.termServicePrivacy()
        r.textColor = .colorOnBackground
        r.font = UIFont.boldSystemFont(ofSize: TEXT_LARGE2)
        r.textAlignment = .center
        return r
    }()
    
    lazy var primaryButton:QMUIButton = {
        let r = ViewFactoryUtil.primaryCapsuleFilledButton()
        r.setTitle(R.string.localizable.agree(), for: .normal)
        return r
    }()
}
