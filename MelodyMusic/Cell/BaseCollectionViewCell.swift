//
//  BaseCollectionViewCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/11/23.
//

import UIKit
import TangramKit

class BaseCollectionViewCell: UICollectionViewCell {
    var container: TGBaseLayout!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        container = TGLinearLayout(getContainerOrientation())
        container.tg_width.equal(.fill)
        container.tg_height.equal(.wrap)
        container.tg_space = PADDING_MIDDLE
        contentView.addSubview(container)
    }
    
    
    func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    func initDatum() {
        
    }
    
    func initListeners() {
        
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.container.systemLayoutSizeFitting(targetSize)
    }
}
