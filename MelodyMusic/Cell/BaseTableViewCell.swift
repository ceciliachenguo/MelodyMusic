//
//  BaseTableViewCell.swift
//  General Use TableView Cell
//
//  Created by Cecilia Chen on 7/27/23.
//

import UIKit
import TangramKit

class BaseTableViewCell: UITableViewCell {

    var container: TGBaseLayout!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    func initViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        //get rid of selection highlighted color
        selectionStyle = .none
        
        container = TGLinearLayout(getContainerOrientation())
        container.tg_width.equal(.fill)
        container.tg_height.equal(.wrap)
        container.tg_space = PADDING_MIDDLE
        contentView.addSubview(container)
    }
    
    func initDatum() {
        
    }
    
    func initListeners() {
        
    }
    
    func getContainerOrientation() -> TGOrientation {
        return .horz
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.container.systemLayoutSizeFitting(targetSize)
    }
    
}
