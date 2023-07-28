//
//  DiscoveryButtonCell.swift
//  Horizontal Scrollable Buttons in Discovery Page
//
//  Created by Cecilia Chen on 7/28/23.
//

import UIKit

class DiscoveryButtonCell: BaseTableViewCell {
    
    static let IDENTITY_NAME = "DiscoveryButtonCell"

    override func initViews() {
        super.initViews()
        let r = UILabel()
        r.text = "sss"
        
        r.tg_height.equal(.wrap)
        r.tg_width.equal(.wrap)
        container.addSubview(r)
    }
}
