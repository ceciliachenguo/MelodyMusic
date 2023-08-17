//
//  DiscoveryFooterCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/16/23.
//

import UIKit
import TangramKit
import SwiftEventBus

class DiscoveryFooterCell: BaseTableViewCell {
    static let NAME = "DiscoveryFooterCell"
    
    override func initViews() {
        super.initViews()
        
        container.tg_gravity = TGGravity.horz.center
        container.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: 0, bottom: PADDING_OUTER, right: 0)
        container.tg_space = PADDING_OUTER
        
        container.addSubview(orientationContainer)
        orientationContainer.addSubview(refreshView)
        
        let infoView = UILabel()
        infoView.tg_width.equal(.wrap)
        infoView.tg_height.equal(.wrap)
        infoView.font = UIFont.systemFont(ofSize: 12)
        infoView.text = R.string.localizable.changeContent()
        infoView.textColor = .black80
        
        orientationContainer.addSubview(infoView)
        
        container.addSubview(customView)
    }
    
    @objc func refreshClick() {
        SwiftEventBus.post(Constants.CLICK_EVENT, sender: MyStyle.refresh)
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    lazy var refreshView: QMUIButton = {
        let r = ViewFactoryUtil.linkButton()
        r.setTitle(R.string.localizable.clickRefresh(), for: .normal)
        
        r.imagePosition = .left
        
        r.setImage(R.image.refresh()!.withTintColor(), for: .normal)
        r.tintColor = .link
        r.setTitleColor(.link, for: .normal)
        r.addTarget(self, action: #selector(refreshClick), for: .touchUpInside)
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_SMALL)
        r.sizeToFit()
        
        return r
    }()
    
    lazy var orientationContainer: TGLinearLayout = {
        let result = TGLinearLayout(.horz)
        result.tg_width.equal(.wrap)
        result.tg_height.equal(.wrap)
        result.tg_space = PADDING_MIDDLE
        result.tg_gravity = TGGravity.vert.center
        
        return result
    }()
    
    lazy var customView: QMUIButton = {
        let r = ViewFactoryUtil.secondHalfFilletSmallButton()
        r.setTitle(R.string.localizable.customDiscovery(), for: .normal)
        return r
    }()
}
