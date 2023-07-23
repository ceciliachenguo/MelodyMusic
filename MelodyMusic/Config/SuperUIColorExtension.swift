//
//  SuperUIColorExtensionswift.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/23/23.
//

import UIKit

import DynamicColor

//iOS中也提供了命名颜色，例如：.systemBackground，但无法更改他的颜色，Android中就可以根据浅色，深色修改命名的颜色，更方便
extension UIColor {
    
    static var primaryColor : UIColor {return DynamicColor(hex: 0x918AE3)}
    
    // darker primary color
    static var primary30 : UIColor {return DynamicColor(hex: 0x706ab0)}
    
    //last 2 indices = opacity
    static var blackTransparent88 : UIColor {return DynamicColor(hex: 0x00000088,useAlpha: true)}
    static var buttonTransparent88 : UIColor {return DynamicColor(hex: 0x00000088,useAlpha: true)}
    static var transparent88 : UIColor {return DynamicColor(hex: 0x88888888,useAlpha: true)}
    static var black11 : UIColor {return DynamicColor(hex: 0xbbbbbb)}
    static var black15 : UIColor {return DynamicColor(hex: 0x111111)}
    static var black17 : UIColor {return DynamicColor(hex: 0x151515)}
    static var black20 : UIColor {return DynamicColor(hex: 0x161616)}
    static var black25 : UIColor {return DynamicColor(hex: 0x191919)}
    static var black30 : UIColor {return DynamicColor(hex: 0x111111)}
    static var black31 : UIColor {return DynamicColor(hex: 0x1b1b1b)}
    static var black311 : UIColor {return DynamicColor(hex: 0x1c1c1c)}
    static var black312 : UIColor {return DynamicColor(hex: 0x1e1e1e)}
    static var black32 : UIColor {return DynamicColor(hex: 0x202020)}
    static var black33 : UIColor {return DynamicColor(hex: 0x242424)}
    static var black322 : UIColor {return DynamicColor(hex: 0x212121)}
    static var black40 : UIColor {return DynamicColor(hex: 0x353535)}
    static var black42 : UIColor {return DynamicColor(hex: 0x353535)}
    static var black43 : UIColor {return DynamicColor(hex: 0x313131)}
    static var black45 : UIColor {return DynamicColor(hex: 0x3c3c3c)}
    static var black66 : UIColor {return DynamicColor(hex: 0x666666)}
    static var black70 : UIColor {return DynamicColor(hex: 0x707070)}
    static var black80 : UIColor {return DynamicColor(hex: 0x888888)}
    static var black90 : UIColor {return DynamicColor(hex: 0xaaaaaa)}
    static var black130 : UIColor {return DynamicColor(hex: 0xc8c8c8)}
    static var black140 : UIColor {return DynamicColor(hex: 0xcfcfcf)}
    static var black150 : UIColor {return DynamicColor(hex: 0xe5e5e5)}
    static var black160 : UIColor {return DynamicColor(hex: 0xd5d5d5)}
    static var black165 : UIColor {return DynamicColor(hex: 0xd1d1d1)}
    static var black170 : UIColor {return DynamicColor(hex: 0xe1e1e1)}
    static var black180 : UIColor {return DynamicColor(hex: 0xededed)}
    static var black183 : UIColor {return DynamicColor(hex: 0xf5f5f5)}
    static var black190 : UIColor {return DynamicColor(hex: 0xf6f6f6)}
    
    static var link : UIColor {return DynamicColor(hex: 0x2440b3)}
    
    /// primary, darker
    static var primaryButton : UIColor {return DynamicColor(hex: 0x596c94)}
    
    /// vip gold
    static var vipBorder : UIColor {return DynamicColor(hex: 0xc4b2ad)}
    
    static var divider2 : UIColor {return DynamicColor(hex: 0x484848)}
    
    /// 亮灰色，例如：设置item右侧图标，右侧更多文本颜色
    static var lightGray : UIColor {return DynamicColor(hex: 0x888888)}
    
    /// warning
    static var warning : UIColor {return DynamicColor(hex: 0xf85353)}
    
    /// coupon, voucher color
    static var textPrice : UIColor {return DynamicColor(hex: 0xf42102)}
    
    /// green, correct
    static var pass : UIColor {return DynamicColor(hex: 0x0ab855)}
}
