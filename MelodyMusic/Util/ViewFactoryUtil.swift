//
//  ViewFactoryUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/23/23.
//

import UIKit
import TangramKit

class ViewFactoryUtil {
    
    /// 主色调,小圆角按钮
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
    
    /// 主色调,半圆角按钮
    static func primaryHalfFilletButton() -> QMUIButton {
        let r = primaryButton()
        r.layer.cornerRadius = BUTTON_MEDIUM_RADIUS
        return r
    }
    
    
    /// 主色调文本,小圆角按钮,灰色边框
    /// - Returns: <#description#>
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
    
    static func primaryHalfFilletOutlineButton() -> QMUIButton {
        let result = primaryOutlineButton()
        result.layer.cornerRadius = BUTTON_MEDIUM_RADIUS
        return result
    }
    
    /// 创建只有标题按钮（类似网页连接）
    static func linkButton() -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = false
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        return r
    }
    
    /// 创建次要，半圆角，小按钮
    /// - Returns: <#description#>
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
    
    /// 创建图片按钮
    static func button(image:UIImage) -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = true
        r.tg_width.equal(30)
        r.tg_height.equal(30)
        r.tintColor = .colorOnSurface
        r.setImage(image, for: .normal)
        return r
    }
    
    static func buttonLarge(_ data:UIImage) -> QMUIButton {
        let result = button(image:data)
        result.tg_width.equal(40)
        result.tg_height.equal(40)
        return result
    }
    
    static func button(title:String,color:UIColor) -> QMUIButton {
        let result = QMUIButton()
        result.adjustsTitleTintColorAutomatically = false
        result.tg_width.equal(.fill)
        result.tg_height.equal(BUTTON_MEDIUM)
        result.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_LARGE3)
        result.setTitle(title, for: .normal)
        result.setTitleColor(color, for: .normal)
        result.backgroundColor = .colorBackground
        
        //按下高亮时的背景色
        result.highlightedBackgroundColor = .colorSurfaceClick
        return result
    }
    
    static func primarySmallHalfFilletButton() -> QMUIButton {
        let result = primaryButton()
        result.tg_width.equal(.wrap)
        result.tg_height.equal(30)
        result.contentEdgeInsets=UIEdgeInsets(top: 0, left: PADDING_MIDDLE, bottom: 0, right: PADDING_MIDDLE)
        result.layer.cornerRadius = BUTTON_SMALL_RADIUS
        return result
    }
    
    static func button(icon:UIImage,title:String) -> QMUIButton {
        let result = QMUIButton()
        result.adjustsTitleTintColorAutomatically = true
        result.tg_width.equal(.fill)
        result.tg_height.equal(46)
        result.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        result.tintColor = .colorOnSurface
        result.setImage(icon, for: .normal)
        result.setTitle(title, for: .normal)
        result.setTitleColor(.colorOnSurface, for: .normal)
        result.imagePosition = .left
        return result
    }
    
    static func secoundButton(icon:UIImage,title:String) -> QMUIButton {
        let result = button(icon: icon, title: title)
        
        //设置图片和文本距离
        result.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: PADDING_SMALL)
        
        result.backgroundColor = .clear
        result.tintColor = .colorOnSurface
        
        return result;
    }
    
    /// 垂直图标，标题按钮
    /// - Parameters:
    ///   - icon: <#icon description#>
    ///   - title: <#title description#>
    /// - Returns: <#description#>
    static func verticalButton(icon:UIImage,title:String) -> QMUIButton {
        let result = QMUIButton()
        result.adjustsTitleTintColorAutomatically = true
        result.tg_width.equal(.wrap)
        result.tg_height.equal(.wrap)
        result.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        result.tintColor = .black80
        result.setImage(icon, for: .normal)
        result.setTitle(title, for: .normal)
        result.setTitleColor(.black80, for: .normal)
        result.imagePosition = .top
        
        //设置图片和文本距离
        result.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: PADDING_SMALL, right: 0)
        
        return result
    }
    
    /// 创建圆形图片按钮
    static func circleButton(_ data:UIImage) -> QMUIButton {
        let result = button(image:data)
        result.backgroundColor = .transparent88
        result.tintColor = .black80
        result.tg_width.equal(44)
        result.tg_height.equal(44)
        result.corner(22)
        return result
    }
    
    
    /// 创建更多 图片控件
    static func moreIconView() -> UIImageView {
        let result = UIImageView()
        result.tg_width.equal(15)
        result.tg_height.equal(15)
        result.image = R.image.superChevronRight()?.withTintColor()
        result.tintColor = .black80
        result.tg_centerY.equal(0)
        
        //图片完全显示到控件里面
        result.contentMode = .scaleAspectFit
        
        return result;
    }
    
    /// 创建TableView
    static func tableView() -> UITableView {
        let r = QMUITableView()
        r.backgroundColor = .clear
        
        //去掉没有数据cell的分割线
        r.tableFooterView = UIView()
        
        //去掉默认分割线
        r.separatorStyle = .none
        
        //修复默认分割线，向右偏移问题
        r.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(.fill)
        
        //设置所有cell的高度为高度自适应，如果cell高度是动态的请这么设置。 如果不同的cell有差异那么可以通过实现协议方法-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
        //如果您最低要支持到iOS7那么请您实现-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath方法来代替这个属性的设置。
        r.rowHeight = UITableView.automaticDimension
        
        r.estimatedRowHeight = UITableView.automaticDimension
        
        //不显示滚动条
        r.showsVerticalScrollIndicator = false
        
        r.allowsSelection = true
        
        //分割线颜色
        r.separatorColor = .colorDivider
        
        return r
    }
    
    /// 创建CollectionView
    static func collectionView() -> UICollectionView {
        let r = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout())
        
        r.backgroundColor = .clear
        
        //不显示滚动条
        r.showsHorizontalScrollIndicator = false
        r.showsVerticalScrollIndicator = false
        
        //collectionView的内容从collectionView顶部距离开始显示，不要自动偏移状态栏尺寸
        r.contentInsetAdjustmentBehavior = .never
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(.fill)
        
        return r
    }
    
    static func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let r = UICollectionViewFlowLayout()
        r.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //滚动方向
        r.scrollDirection = .vertical
        
        //每个Cell的行间距
        r.minimumLineSpacing = 0
        
        //每个Cell的列间距
        r.minimumInteritemSpacing = 0
        
        return r
    }
    
    static func pageCollectionView() -> UICollectionView {
        let result = UICollectionView(frame: .zero, collectionViewLayout: pageCollectionViewFlowLayout())
        result.isPagingEnabled = true
        result.backgroundColor = .clear
        
        //不显示滚动条
        result.showsHorizontalScrollIndicator=false
        result.showsVerticalScrollIndicator = false

        //tableView的内容从tableView顶部距离开始显示，不要自动偏移状态栏尺寸
        result.contentInsetAdjustmentBehavior = .never
        
        result.tg_width.equal(.fill)
        result.tg_height.equal(.fill)
        
        return result
    }
    
    static func pageCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let result = UICollectionViewFlowLayout()
        result.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        //滚动方向
        result.scrollDirection = .horizontal

        //每个Cell的行间距
        result.minimumLineSpacing = 0

        //每个Cell的列间距
        result.minimumInteritemSpacing = 0

        return result
    }
    
    /// 创建小水平分割线
    static func smallDivider() -> UIView {
        let r = UIView()
        r.tg_width.equal(.fill)
        r.tg_height.equal(PADDING_MIN)
        r.backgroundColor = .colorDivider
        return r
    }
    
    static func smallVerticalDivider() -> UIView {
        let r = UIView()
        r.tg_width.equal(PADDING_MIN)
        r.tg_height.equal(.fill)
        r.backgroundColor = .colorDivider
        return r
    }
    
    /// 创建水平分割线
    static func divider() -> UIView {
        let result = UIView()
        result.tg_width.equal(.fill)
        result.tg_height.equal(PADDING_MIDDLE)
        result.backgroundColor = .colorDivider
        return result
    }
    
    static func orientationContainer(_ orientation:TGOrientation = .horz) -> TGLinearLayout {
        let result = TGLinearLayout(orientation)
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        
        return result
    }
    
}
