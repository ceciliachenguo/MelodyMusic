//
//  SongCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/10/23.
//

import UIKit
import TangramKit

class SongCell: BaseTableViewCell {
    
    override func initViews() {
        super.initViews()
        container.tg_space = 0
        container.backgroundColor = .colorLightWhite
        
        //右侧有边距
        container.tg_padding = UIEdgeInsets(top: PADDING_SMALL, left: 0, bottom: 0, right: PADDING_SMALL)
        container.tg_gravity = TGGravity.vert.center
        
        //左侧容器
        let leftContainer = TGRelativeLayout()
        leftContainer.tg_width.equal(50)
        leftContainer.tg_height.equal(50)
        container.addSubview(leftContainer)
        
        //索引
        leftContainer.addSubview(self.indexView)
        
        //右侧容器
        let rightContainer = TGLinearLayout(.vert)
        rightContainer.tg_width.equal(.fill)
        rightContainer.tg_height.equal(.wrap)
        rightContainer.tg_space = PADDING_SMALL
        container.addSubview(rightContainer)
        
        //标题
        rightContainer.addSubview(self.titleView)
        
        //信息容器
        let infoContainer = TGLinearLayout(.horz)
        infoContainer.tg_width.equal(.fill)
        infoContainer.tg_height.equal(.wrap)
        infoContainer.tg_space = PADDING_SMALL
        rightContainer.addSubview(infoContainer)
        
        infoContainer.addSubview(self.downloadedView)
        infoContainer.addSubview(self.infoView)
        
        //更多按钮
        let moreButton = ViewFactoryUtil.button(image:R.image.moreVerticalDot()!.withTintColor())
        moreButton.tintColor = .black80
        moreButton.tg_width.equal(50)
        moreButton.tg_height.equal(50)
        container.addSubview(moreButton)
    }
    
    func bind(_ data:Song) {
        titleView.text = data.title
        infoView.text = "\(data.singer.nickname!) - 这是专辑"
    }
    
    lazy var indexView: UILabel = {
        let result = UILabel()
        result.tg_width.equal(.wrap)
        result.tg_height.equal(.wrap)
        result.tg_centerX.equal(0)
        result.tg_centerY.equal(0)
        result.numberOfLines = 1
        result.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        result.textColor = .black80
        
        return result
    }()
    
    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 1
        r.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        r.textColor = .colorOnSurface
        
        return r
    }()
    
    lazy var downloadedView: UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(.wrap)
        r.tg_height.equal(.wrap)
        r.tg_visibility = .gone
        r.image = R.image.downloaded()
        
        return r
    }()
    
    lazy var infoView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 1
        r.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.textColor = .black80
        
        return r
    }()
}
