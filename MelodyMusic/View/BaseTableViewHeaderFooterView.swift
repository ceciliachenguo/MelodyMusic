//
//  BaseTableViewHeaderFooterView.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/11/23.
//

import UIKit
import TangramKit

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    //对于需要动态评估高度的UITableViewCell来说可以把布局视图暴露出来。用于高度评估和边界线处理。以及事件处理的设置。
    var container:TGBaseLayout!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        innerInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        innerInit()
    }
    
    func innerInit() {
        initViews()
        initDatum()
        initListeners()
    }
    
    /// 找控件
    func initViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        container = TGLinearLayout(getContainerOrientation())
        container.tg_width.equal(.fill)
        container.tg_height.equal(.wrap)
        contentView.addSubview(container)
    }
    
    /// 设置数据
    func initDatum() {
        
    }
    
    /// 设置监听器
    func initListeners()  {
        
    }

    /// 获取根容器布局方向
    func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    /// 使用MyLayout后，让item自动计算高度，要重写该方法
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.container.systemLayoutSizeFitting(targetSize)
    }
}
