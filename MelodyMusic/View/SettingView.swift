//
//  SettingView.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/22/23.
//

import UIKit
import TangramKit

class SettingView: TGRelativeLayout {
    init() {
        super.init(frame: CGRect.zero)
        innerInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        innerInit()
    }
    
    func innerInit() {
        tg_width.equal(.fill)
        tg_height.equal(55)
        
        backgroundColor = .white
        addSubview(iconView)
        addSubview(titleView)
        addSubview(moreIconView)
    }
    
    /// 左侧图标
    lazy var iconView: UIImageView = {
        let result = UIImageView()
        result.image = UIImage(systemName: "gearshape")

        result.tg_width.equal(20)
        result.tg_height.equal(20)
        result.tg_centerY.equal(0)
        result.tg_leading.equal(16)
        return result
    }()
    
    /// 标题
    lazy var titleView: UILabel = {
        let result = UILabel()
        result.text = "Setting"
        result.tg_width.equal(.wrap)
        result.tg_height.equal(.wrap)
        result.tg_centerY.equal(0)
        result.tg_leading.equal(iconView.tg_trailing).offset(16)
        return result
    }()

    /// 右侧图标
    lazy var moreIconView: UIImageView = {
        let result = UIImageView()
        result.image = UIImage(systemName: "arrow.right")
        result.tg_width.equal(20)
        result.tg_height.equal(20)
        result.tg_centerY.equal(0)
        result.tg_right.equal(16)
        return result
    }()

}

