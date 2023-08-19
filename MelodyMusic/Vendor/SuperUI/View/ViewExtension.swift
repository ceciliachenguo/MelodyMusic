//
//  ViewExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/19/23.
//

import Foundation
import TangramKit

extension UIView {
    func hide() {
        tg_visibility = .gone
    }
    
    func show(_ sender:Bool=true) {
        tg_visibility = .visible
    }
    
    func invisible() {
        tg_visibility = TGVisibility.invisible
    }
    
    func isShow() -> Bool {
        return tg_visibility == TGVisibility.visible
    }
    
    func toggle() {
        if (isShow()) {
            hide()
        } else {
            show()
        }
    }
}
