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
        r.layer.cornerRadius = SMALL_RADIUS
        r.tintColor = .colorLightWhite
        r.setTitleColor(.colorLightWhite, for: .normal)
        return r
    }
    
    static func primaryCapsuleFilledButton() -> QMUIButton {
        let r = primaryButton()
        r.layer.cornerRadius = BUTTON_MEDIUM_RADIUS
        return r
    }
    
    static func primaryOutlineButton() -> QMUIButton {
        let r = primaryButton()
        r.layer.cornerRadius = SMALL_RADIUS
        r.tintColor = .black130
        r.layer.borderWidth = 1
        r.layer.borderColor = UIColor.black130.cgColor
        r.backgroundColor = .clear
        r.setTitleColor(.colorPrimary, for: .normal)
        return r
    }
    
    static func linkButton() -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = false
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        return r
    }
    
    static func secondHalfFilletSmallButton() -> QMUIButton {
        let r = QMUIButton()
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_SMALL)
        r.tg_width.equal(90)
        r.tg_height.equal(BUTTON_SMALL)
        r.tintColor = .black80
        r.border(.black80)
        r.corner(BUTTON_SMALL_RADIUS)
        r.setTitleColor(.black80, for: .normal)
        return r
    }
    
    static func button(image:UIImage) -> QMUIButton {
        let r = QMUIButton()
        r.adjustsImageTintColorAutomatically = true
        r.tg_width.equal(30)
        r.tg_height.equal(30)
        r.tintColor = .colorOnSurface
        r.setImage(image, for: .normal)
        return r
    }
    
    static func moreIconView() -> UIImageView {
        let result = UIImageView()
        result.tg_width.equal(15)
        result.tg_height.equal(15)
        result.image = R.image.superChevronRight()?.withTintColor()
        result.tintColor = .black80
        result.tg_centerY.equal(0)
        
        result.contentMode = .scaleAspectFit
        return result
    }
    
    static func tableView() -> UITableView {
        let r = QMUITableView()
        r.backgroundColor = .clear
        
        //get rid of separators when there is no content is cells
        r.tableFooterView = UIView()
        r.separatorStyle = .none
        r.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(.fill)
        
        //Auto ajust the length of the whole list
        r.rowHeight = UITableView.automaticDimension
        r.estimatedRowHeight = UITableView.automaticDimension
        
        //No scroll indication
        r.showsVerticalScrollIndicator = false
        
        r.allowsSelection = true
        
        return r
    }
    
    static func smallDivider() -> UIView {
        let r = UIView()
        r.tg_width.equal(.fill)
        r.tg_height.equal(0.5)
        r.backgroundColor = .colorDivider
        
        return r
    }
    
    static func collectionView() -> UICollectionView {
        let r = UICollectionView(frame: CGRect.zero, collectionViewLayout: collecionviewLayout())
        r.backgroundColor = .clear
        r.showsHorizontalScrollIndicator = false
        r.showsVerticalScrollIndicator = false
        
        r.contentInsetAdjustmentBehavior = . never
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(.fill)
        
        return r
    }
    
    static func collecionviewLayout() -> UICollectionViewFlowLayout {
        let r = UICollectionViewFlowLayout()
        r.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        r.scrollDirection = .vertical
        r.minimumLineSpacing = 0
        r.minimumInteritemSpacing = 0
        return r
    }
}
