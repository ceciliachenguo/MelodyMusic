//
//  BaseRelativeLayout.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import UIKit
import TangramKit

class BaseRelativeLayout: TGRelativeLayout {
    init() {
        super.init(frame: .zero)
        initViews()
        initDatum()
        initListeners()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
        initDatum()
        initListeners()
    }
    
    /// 找控件
    func initViews() {
        
    }

    /// 设置数据
    func initDatum() {
        
    }

    /// 设置监听器
    func initListeners()  {
        
    }
}
