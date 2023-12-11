//
//  SongGroupHeaderView.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/11/23.
//

import UIKit
import TangramKit

class SongGroupHeaderView: BaseTableViewHeaderFooterView {
    static let NAME = "SongGroupHeaderView"
    
    var countView:UILabel!
    
    /// 播放所有点击
    var playAllClick:(()->Void)!
    
    override func initViews() {
        super.initViews()
        backgroundColor = .colorBackgroundLight
        contentView.backgroundColor = .colorBackgroundLight
        
        container.tg_gravity = TGGravity.vert.center
        
        container.tg_padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: PADDING_SMALL)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onPlayAllTouchEvent(_:)))

        //将触摸事件添加到当前view
        container.addGestureRecognizer(tapGestureRecognizer)
        
        //左侧容器
        let leftContainer = TGRelativeLayout()
        leftContainer.tg_width.equal(50)
        leftContainer.tg_height.equal(50)
        container.addSubview(leftContainer)
        
        //图标
        let iconView = UIImageView()
        iconView.tg_width.equal(30)
        iconView.tg_height.equal(30)
        iconView.tg_centerX.equal(0)
        iconView.tg_centerY.equal(0)
        iconView.image = R.image.playCircle()?.withTintColor()
        iconView.tintColor = .colorPrimary
        
        leftContainer.addSubview(iconView)
        
        //播放全部提示文本
        let titleView = UILabel()
        titleView.tg_width.equal(.wrap)
        titleView.tg_height.equal(.wrap)
        titleView.text = R.string.localizable.playAll()
        titleView.font = UIFont.boldSystemFont(ofSize: TEXT_LARGE2)
        titleView.textColor = .colorOnSurface
        container.addSubview(titleView)
        
        //数量
        countView = UILabel()
        countView.tg_width.equal(.fill)
        countView.tg_height.equal(.wrap)
        countView.text = "0"
        countView.textAlignment = .left
        countView.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        countView.textColor = .black80
        container.addSubview(countView)
        
        //下载按钮
        let downloadButton = ViewFactoryUtil.button(image:R.image.arrowCircleDown()!.withTintColor())
        downloadButton.tintColor = .colorOnSurface
        downloadButton.tg_width.equal(50)
        downloadButton.tg_height.equal(50)
        container.addSubview(downloadButton)
        
        //多选按钮
        let multiSelectButton = ViewFactoryUtil.button(image:R.image.moreVerticalDot()!.withTintColor())
        multiSelectButton.tintColor = .colorOnSurface
        multiSelectButton.tg_width.equal(50)
        multiSelectButton.tg_height.equal(50)
        container.addSubview(multiSelectButton)
    }

    override func getContainerOrientation() -> TGOrientation {
        return .horz
    }
    
    @objc func onPlayAllTouchEvent(_ recognizer:UITapGestureRecognizer) {
        playAllClick()
    }
    
    func bind(_ data:SongGroupData) {
        countView.text = "(\(data.datum.count))"
    }
}
