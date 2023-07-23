//
//  ViewFactoryUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/23/23.
//

import UIKit
import TangramKit

class ViewFactoryUtil {
    
    static func primaryButton() -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = false
        r.adjustsButtonWhenHighlighted = true
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        r.tg_width.equal(.fill)
        r.tg_height.equal(BUTTON_MEDIUM)
        r.backgroundColor = .colorPrimary
        r.cornerRadius = SMALL_RADIUS
        r.tintColor = .colorLightWhite
        r.setTitleColor(.colorLightWhite, for: .normal)
        return r
    }
    
    static func primaryCapsuleFilledButton() -> QMUIButton {
        let r = primaryButton()
        r.layer.cornerRadius = BUTTON_MEDIUM_RADIUS
        return r
    }
    
    static func linkButton() -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = false
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        return r
    }
}
