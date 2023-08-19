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
    }
    
    lazy var toolbarView:SuperToolbarView = {
        let r = SuperToolbarView()
        return r
    }()
}
