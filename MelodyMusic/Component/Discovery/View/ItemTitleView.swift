//
//  ItemTitleView.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/11/23.
//

import UIKit
import TangramKit

class ItemTitleView: TGRelativeLayout {

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
        tg_height.equal(.wrap)
        
        tg_padding = UIEdgeInsets(top: PADDING_MIDDLE, left: PADDING_OUTER, bottom: PADDING_MIDDLE, right: PADDING_OUTER)
        
        addSubview(titleView)
        addSubview(moreIconView)
    }
    
    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.wrap)
        r.tg_height.equal(.wrap)
        r.tg_centerY.equal(0)
        r.numberOfLines = 1
        r.font = UIFont.systemFont(ofSize: TEXT_LARGE2)
        r.textColor = .colorOnSurface
        return r
    }()
    
    lazy var moreIconView:UIImageView = {
        let result = UIImageView()
        result.tg_width.equal(15)
        result.tg_height.equal(15)
        result.image = R.image.superChevronRight()?.withTintColor()
        result.tintColor = .colorPrimary
        result.tg_centerY.equal(0)
        result.tg_right.equal(0)
        result.contentMode = .scaleAspectFit
        return result
    }()

}
