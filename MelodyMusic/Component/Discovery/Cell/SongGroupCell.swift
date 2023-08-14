//
//  SongGroupCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/14/23.
//

import UIKit
import TangramKit

class SongGroupCell: BaseTableViewCell {
    static let NAME = "SongGroupCell"
    
    override func initViews() {
        super.initViews()
        container.addSubview(ViewFactoryUtil.smallDivider())
        
        container.addSubview(titleView)
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    func bind(_ data:SongData) {
    }
    
    lazy var titleView: ItemTitleView = {
        let r = ItemTitleView()
        r.titleView.text = R.string.localizable.recommendSong()
        return r
    }()
    
}
