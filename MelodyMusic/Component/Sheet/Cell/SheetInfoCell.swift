//
//  SheetInfoCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/10/23.
//

import UIKit
import TangramKit

class SheetInfoCell: BaseTableViewCell {
    static let NAME = "SheetInfoCell"

    var iconView:UIImageView!
    
    override func initViews() {
        super.initViews()
        container.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_LARGE2, right: PADDING_OUTER)
        container.tg_space = PADDING_LARGE2
        
        //水平容器
        let orientationContainer = ViewFactoryUtil.orientationContainer()
        orientationContainer.tg_space = PADDING_OUTER
        orientationContainer.tg_gravity = TGGravity.vert.center
        orientationContainer.tg_padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: PADDING_SMALL)
        container.addSubview(orientationContainer)
        
        //图标
        iconView = UIImageView()
        iconView.tg_width.equal(120)
        iconView.tg_height.equal(120)
        iconView.image = R.image.placeholder()
        iconView.smallCorner()
        iconView.contentMode = .scaleAspectFill
        
        orientationContainer.addSubview(iconView)
        
        //右侧容器
        let rightContainer = TGLinearLayout(.vert)
        rightContainer.tg_width.equal(.fill)
        rightContainer.tg_height.equal(.wrap)
        rightContainer.tg_space = PADDING_SMALL
        orientationContainer.addSubview(rightContainer)
        
        //标题
        rightContainer.addSubview(self.titleView)
        
        //用户容器
        let userContainer = ViewFactoryUtil.orientationContainer()
        userContainer.tg_space = PADDING_SMALL
        userContainer.tg_gravity = TGGravity.vert.center
        rightContainer.addSubview(userContainer)
        
        userContainer.addSubview(self.avatarView)
        userContainer.addSubview(self.nicknameView)
        
        //详情容器
        let detailContainer = ViewFactoryUtil.orientationContainer()
        
        //类似paddingTop
        detailContainer.tg_top.equal(PADDING_MIDDLE)
        detailContainer.tg_space = PADDING_SMALL
        userContainer.tg_gravity = TGGravity.vert.center
        rightContainer.addSubview(detailContainer)
        
        detailContainer.addSubview(self.detailView)
        detailContainer.addSubview(ViewFactoryUtil.moreIconView())
        
        //快捷按钮容器
        let buttonContainer = ViewFactoryUtil.orientationContainer()
        buttonContainer.corner(23)
        buttonContainer.tg_horzMargin(PADDING_LARGE2)
        buttonContainer.tg_height.equal(46)
        container.addSubview(buttonContainer)
        
        buttonContainer.addSubview(self.collectCountView)
        buttonContainer.addSubview(ViewFactoryUtil.smallVerticalDivider())
        buttonContainer.addSubview(self.commentCountView)
        buttonContainer.addSubview(ViewFactoryUtil.smallVerticalDivider())
        buttonContainer.addSubview(self.shareCountView)
    }
    
    func bind(_ data:Sheet) {
//        iconView.show(data.icon)
        iconView.show2(data.icon)
        titleView.text = data.title
        avatarView.show2(data.user.icon)
        nicknameView.text = data.user.nickname
        detailView.text = data.detail
        
        collectCountView.setTitle("\(data.collectsCount)", for: .normal)
        commentCountView.setTitle("\(data.commentsCount)", for: .normal)
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 2
        r.font = UIFont.systemFont(ofSize: TEXT_LARGE2)
        r.textColor = .colorLightWhite
        return r
    }()
    
    lazy var avatarView: UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(30)
        r.tg_height.equal(30)
        r.contentMode = .scaleAspectFill
        r.smallCorner()
        return r
    }()
    
    lazy var nicknameView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.wrap)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 1
        r.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.textColor = .colorLightWhite
        return r
    }()
    
    lazy var detailView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(160)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 1
        r.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.textColor = .colorLightWhite
        return r
    }()
    
    lazy var collectCountView: QMUIButton = {
        let r = ViewFactoryUtil.secoundButton(icon: R.image.search()!.withTintColor(), title: "0")
        r.backgroundColor = .colorLightWhite
        return r
    }()
    
    lazy var commentCountView: QMUIButton = {
        let r = ViewFactoryUtil.secoundButton(icon: R.image.search()!.withTintColor(), title: "0")
        r.backgroundColor = .colorLightWhite
        return r
    }()
    
    lazy var shareCountView: QMUIButton = {
        let r = ViewFactoryUtil.secoundButton(icon: R.image.search()!.withTintColor(), title: "0")
        r.backgroundColor = .colorLightWhite
        return r
    }()
}
