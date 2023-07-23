//
//  SuperUIThemeExtension.swift
//  dynamic color definition
//
//  Created by Cecilia Chen on 7/23/23.
//

import UIKit

extension UIColor{
    /// primary color
    static var colorPrimary: UIColor {
        return .initColor(normal: .primaryColor, dark: .primary30)
    }

    /// background
    static var colorBackground: UIColor {
        return .initColor(normal: .black183, dark: .black17)
    }

    
    static var colorBackgroundLight: UIColor {
        return .initColor(normal: .white, dark: .black17)
    }

    /// content color on the background
    static var colorOnBackground: UIColor {
        return .initColor(normal: .black20, dark: .black140)
    }

    /// 背景色上面内容背景颜色，例如card背景，会话界面item背景，其他的例如LinearLayout这样的控件，需要手动指定使用该属性
    static var colorSurface: UIColor {
        return .initColor(normal: .white, dark: .black33)
    }

    /// colorSurface click color
    static var colorSurfaceClick: UIColor {
        return .initColor(normal: .black130, dark: .black322)
    }

    /// colorSurface上面的主内容颜色，例如：card上面主要内容颜色，会话界面item上面标题颜色
    static var colorOnSurface: UIColor {
        return .initColor(normal: .black25, dark: .black165)
    }

    static var colorDivider: UIColor {
        return .initColor(normal: .black180, dark: .black33)
    }

    static var colorDivider2: UIColor {
        return .initColor(normal: .black170, dark: .black30)
    }

    static var colorSlideBackground: UIColor {
        return .initColor(normal: .black170, dark: .black17)
    }

    static var colorLightWhite: UIColor {
        return .initColor(normal: .white, dark: .black180)
    }

    static var secondButtonLight: UIColor {
        return .initColor(normal: .white, dark: .black45)
    }

    /// 文本消息左侧背景
    static var leftChatBackground: UIColor {
        return .initColor(normal: .black170, dark: .black17)
    }

    /// 文本消息右侧背景
    static var rightChatBackground: UIColor {
        return .initColor(normal: .colorPrimary, dark: .colorPrimary)
    }
    
    // MARK: - 颜色定义快捷方法
        
    /// define light color，dark color shortcut
    /// - Returns: <#description#>
    static func initColor(normal:UIColor,dark:UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? dark : normal
            }
        }else{
            //use light color
            return normal
        }
    }
}
