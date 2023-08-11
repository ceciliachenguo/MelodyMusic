//
//  ViewCornerExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/11/23.
//

import UIKit

extension UIView {
    func smallCorner() {
        corner(SuperConfig.SIZE_SMALL_RADIUS)
    }
    
    func largeCorner() {
        corner(SuperConfig.SIZE_LARGE_RADIUS)
    }
    
    func corner(_ radius:CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func border(_ color: UIColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
}
