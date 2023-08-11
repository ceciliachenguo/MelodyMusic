//
//  SheetGroupCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/11/23.
//

import UIKit
import TangramKit

class SheetGroupCell: BaseTableViewCell {
    static let NAME = "SheetGroupCell"

    override func initViews() {
        super.initViews()
        
        container.addSubview(ViewFactoryUtil.smallDivider())
        
        container.addSubview(titleView)
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    func bind(_ data: SheetData) {
        
    }
    
    lazy var titleView: ItemTitleView = {
        let r = ItemTitleView()
        r.titleView.text = R.string.localizable.recommendSheet()
        return r
    }()

}
