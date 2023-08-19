//
//  SuperToolbarView.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/19/23.
//

import UIKit
import TangramKit

class SuperToolbarView: TGRelativeLayout {
    init() {
        super.init(frame: CGRect.zero)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    func initViews() {
        tg_width.equal(.fill)
        tg_height.equal(50)
        
        addSubview(leftContainer)
        
        addSubview(centerContainer)
        centerContainer.addSubview(titleView)
        
        addSubview(rightContainer)
    }
    
    @discardableResult
    func addLeftItem(_ data:UIView) -> SuperToolbarView {
        leftContainer.addSubview(data)
        return self
    }
    
    @discardableResult
    func addCenterView(_ data:UIView) -> SuperToolbarView {
        titleView.hide()
        
        centerContainer.addSubview(data)
        return self
    }
    
    @discardableResult
    func addRightItem(_ data:UIView) -> SuperToolbarView {
        rightContainer.addSubview(data)
        return self
    }
    
    @discardableResult
    func setToolbarLight() -> SuperToolbarView {
        titleView.textColor = .colorLightWhite
        
        for it in leftContainer.subviews {
            it.tintColor = .colorLightWhite
        }
        
        for it in rightContainer.subviews {
            it.tintColor = .colorLightWhite
        }
        
        return self
    }
    
    lazy var leftContainer: TGLinearLayout = {
        let r = TGLinearLayout(.horz)
        r.tg_space = PADDING_MIDDLE
        r.tg_gravity = TGGravity.vert.center
        r.tg_leading.equal(12)
        r.tg_trailing.equal(centerContainer.tg_leading).offset(PADDING_MIDDLE)
        r.tg_height.equal(.fill)
        return r
    }()
    
    
    lazy var centerContainer: TGLinearLayout = {
        let r = TGLinearLayout(.horz)
        r.tg_width.equal(.wrap)
        r.tg_height.equal(.fill)
        r.tg_gravity = TGGravity.vert.center
        r.tg_centerX.equal(0)
        r.tg_centerY.equal(0)
        return r
    }()
    
    private lazy var rightContainer: TGLinearLayout = {
        let r = TGLinearLayout(.horz)
        r.tg_space = PADDING_MIDDLE
        r.tg_gravity = [TGGravity.vert.center,TGGravity.horz.right]
        r.tg_trailing.equal(12)
        r.tg_leading.equal(centerContainer.tg_trailing).offset(PADDING_MIDDLE)
        r.tg_height.equal(.fill)
        return r
    }()
    
    lazy var titleView: UILabel = {
        let result=UILabel()
        result.tg_width.equal(SCREEN_WIDTH - 150)
        result.tg_height.equal(.wrap)
        result.numberOfLines=1
        result.textAlignment = .center
        result.font = UIFont.systemFont(ofSize: TEXT_LARGE3)
        result.textColor = .colorOnSurface
        return result
    }()
}
