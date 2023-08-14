//
//  DiscoverySongCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/14/23.
//

import UIKit
import TangramKit

class DiscoverySongCell: BaseTableViewCell {
    static let NAME = "DiscoverySongCell"
    
    override func initViews() {
        super.initViews()
        container.tg_space = PADDING_MIDDLE
        container.tg_gravity = TGGravity.vert.center
        
        container.addSubview(iconView)
        container.addSubview(rightContainer)
        
        rightContainer.addSubview(titleView)
        rightContainer.addSubview(infoView)
    }

    func bind(_ data:Song) {
        iconView.sd_setImage(with: URL(string: data.icon!.absoluteURL()), placeholderImage: R.image.placeholder())
        
        titleView.text = data.title
        
        infoView.text = "\(data.singer.nickname!)-This is Collection Name"
    }
    
    lazy var iconView: UIImageView = {
        let result=UIImageView()
        result.tg_width.equal(51)
        result.tg_height.equal(51)
        result.image = R.image.dayRecommend()
        result.clipsToBounds=true
        
        result.contentMode = .scaleAspectFill
        
        result.smallCorner()
        return result
    }()
    
    lazy var rightContainer: TGLinearLayout = {
        let result=TGLinearLayout(.vert)
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        
        result.tg_space = PADDING_SMALL
        return result
    }()
    
    lazy var titleView: UILabel = {
        let result=UILabel()
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 14)
        result.textColor = .colorOnSurface
        return result
    }()
    
    lazy var infoView: UILabel = {
        let result=UILabel()
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        result.font = UIFont.systemFont(ofSize: 12)
        result.textColor = .black80
        return result
    }()

}
