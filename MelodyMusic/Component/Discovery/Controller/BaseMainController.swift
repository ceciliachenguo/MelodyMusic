//
//  BaseMainController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/19/23.
//

import UIKit

class BaseMainController: BaseTitleController {

    override func initViews() {
        super.initViews()
        setBackgroundColor(.colorBackgroundLight)
        
        addLeftImageButton(R.image.menu()!)
        addRightImageButton(R.image.mic()!)
        
        toolbarView.addCenterView(searchButton)
    }
    
    lazy var searchButton:QMUIButton = {
        let r = QMUIButton()
        r.tg_width.equal(SCREEN_WIDTH - 50 * 2)
        r.tg_height.equal(35)
        r.adjustsTitleTintColorAutomatically = true
        r.tintColor = .black80
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.corner(17.5)
        r.setTitle(R.string.localizable.hintSearchValue(), for: .normal)
        r.setTitleColor(.black80, for: .normal)
        r.backgroundColor = .colorDivider
        r.setImage(R.image.search()!.withTintColor(), for: .normal)
        r.imagePosition = .left
        r.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: PADDING_SMALL)
        r.addTarget(self, action: #selector(searchClick(_:)), for: .touchUpInside)
        return r
    }()
    
    @objc func searchClick(_ sender: QMUIButton) {
        
    }

}
