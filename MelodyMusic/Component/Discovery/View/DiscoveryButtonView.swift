//
//  DiscoveryButtonView.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/28/23.
//

import UIKit
import TangramKit

class DiscoveryButtonView: TGLinearLayout{

    init () {
        super.init(frame: CGRect.zero, orientation: .vert)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    func initViews() {
        tg_width.equal(.wrap)
        tg_height.equal(.wrap)
        
        tg_space = PADDING_MIDDLE
        
        tg_gravity = TGGravity.horz.center
        
        let iconContainer = TGRelativeLayout()
        iconContainer.tg_width.equal(50)
        iconContainer.tg_height.equal(50)
        
        addSubview(iconContainer)
        
        iconContainer.addSubview(iconView)
        iconContainer.addSubview(tipView)
        
        addSubview(titleView)
    }
    
    func bind(_ title:String!, _ icon:UIImage!) {
        titleView.text = title
        iconView.image = icon
    }
    
    lazy var iconView: UIImageView = {
        let r = UIImageView()
        r.tg_height.equal(.fill)
        r.tg_width.equal(.fill)
        r.image = R.image.dayRecommend()
        return r
    }()
    
    lazy var tipView: UILabel = {
        let r = UILabel()
        r.tg_height.equal(.wrap)
        r.tg_width.equal(.wrap)
        r.textColor = UIColor(named: "AccentColor")
        r.font = UIFont.systemFont(ofSize: 13)
        
        r.tg_centerX.equal(0)
        r.tg_centerY.equal(3)

        return r
    }()
    
    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_height.equal(.wrap)
        r.tg_width.equal(.wrap)
        r.textColor = .colorOnSurface
        r.font = UIFont.systemFont(ofSize: 13)
        r.text = "6"
        return r
    }()
    
    
}
