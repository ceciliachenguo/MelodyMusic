//
//  SheetCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/11/23.
//

import UIKit
import TangramKit

class SheetCell: BaseCollectionViewCell {
    override func initViews() {
        super.initViews()
        container.tg_space = PADDING_SMALL
        
        container.addSubview(iconView)
        container.addSubview(titleView)
    }
    
    func bind(_ data: Sheet) {
        titleView.text = data.title
    }
    
    lazy var iconView:UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(.fill)
        r.tg_height.equal(r.tg_width)
        r.image = R.image.placeholder()
        r.contentMode = .scaleAspectFill
        r.smallCorner()
        
        return r
    }()
    
    lazy var titleView:UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 2
        r.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.textColor = .colorOnSurface
        
        return r
    }()
}
