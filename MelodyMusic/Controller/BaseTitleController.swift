//
//  BaseTitleController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/23/23.
//

import UIKit

class BaseTitleController: BaseLogicController {

    override func initLinearLayoutSafeArea() {
        super.initLinearLayoutSafeArea()
        prepareInitToolbar()
    }
    
    override func initRelativeLayoutSafeArea() {
        super.initRelativeLayoutSafeArea()
        prepareInitToolbar()
    }
    
    func prepareInitToolbar() {
        if isAddToolBar() {
            initToolbar()
        }
    }
    
    override var title: String?{
        didSet {
            toolbarView.titleView.text = title
        }
    }
    
    func isAddToolBar() -> Bool {
        return true
    }
    
    func initToolbar() {
        superHeaderContentContainer.addSubview(toolbarView)
        
        if navigationController?.viewControllers.count != 1 {
            let r = addLeftImageButton(R.image.arrowLeft()!.withTintColor())
            r.tag = VALUE10
        }
    }
    
    func addLeftImageButton(_ data:UIImage) -> QMUIButton {
        let leftButton = ViewFactoryUtil.button(image: data)
        leftButton.addTarget(self, action: #selector(leftClick(_:)), for: .touchUpInside)
        toolbarView.addLeftItem(leftButton)
        return leftButton
    }
    
    func addRightImageButton(_ data:UIImage){
        let rightButton = ViewFactoryUtil.button(image: data)
        rightButton.addTarget(self, action: #selector(rightClick(_:)), for: .touchUpInside)
        toolbarView.addRightItem(rightButton)
    }
    
    func addRightButton(_ data:String) -> QMUIButton{
        let rightButton = ViewFactoryUtil.linkButton()
        rightButton.setTitle(data, for: .normal)
        rightButton.setTitleColor(.colorOnSurface, for: .normal)
        rightButton.addTarget(self, action: #selector(rightClick(_:)), for: .touchUpInside)
        rightButton.sizeToFit()
        toolbarView.addRightItem(rightButton)
        return rightButton
    }
    
    @objc func leftClick(_ sender:QMUIButton) {
        if sender.tag == VALUE10 {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func rightClick(_ sender:QMUIButton) {
        print("right clicked")
    }
    
    lazy var toolbarView:SuperToolbarView = {
        let r = SuperToolbarView()
        return r
    }()
}
