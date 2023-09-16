//
//  SuperInputView.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import UIKit
import TangramKit

class SuperInputView: BaseRelativeLayout {
    var container:TGBaseLayout!
    var maxCount = -1
    
    override func initViews() {
        super.initViews()
        tg_width.equal(.fill)
        tg_height.equal(.wrap)
    }
    
    func initInput() {
        container = ViewFactoryUtil.orientationContainer()
        container.tg_space = PADDING_MIDDLE
        container.tg_gravity = TGGravity.vert.center
        addSubview(container)
        
        container.addSubview(iconView)
        container.addSubview(textFieldView)
    }
    
    func bottomBorder() {
        qmui_borderColor = .black90
        qmui_borderPosition = .bottom
    }
    
    func initMultiInput(_ maxCount:Int = -1) {
        self.maxCount = maxCount
        
        container = TGRelativeLayout()
        container.tg_width.equal(.fill)
        container.tg_height.equal(.wrap)
        addSubview(container)
        
        container.addSubview(textView)
        
        if isCount() {
            container.addSubview(countView)
            countView.text = "\(0)/\(maxCount)"
        }
    }
    
    func isCount() -> Bool {
        return maxCount != -1
    }
    
    func smallBorder() {
        layer.cornerRadius = SMALL_RADIUS
        layer.borderWidth = 1
        layer.borderColor = UIColor.colorDivider.cgColor
        
        //padding on 2 sides
        container.tg_leadingPadding = PADDING_MIDDLE
        container.tg_trailingPadding = PADDING_MIDDLE
    }
    
    @discardableResult
    func passwordStyle() -> SuperInputView {
        textFieldView.isSecureTextEntry = true
        return self
    }
    
    @discardableResult
    func phoneStyle() -> SuperInputView {
        textFieldView.keyboardType = .phonePad
        return self
    }
    
    @discardableResult
    func emailStyle() -> SuperInputView {
        textFieldView.textContentType = .emailAddress
        textFieldView.keyboardType = .emailAddress
        return self
    }
    
    lazy var iconView: UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(20)
        r.tg_height.equal(20)
        r.tintColor = .black66
        r.image = R.image.inputUsername()!.withTintColor()
        r.hide()
        return r
    }()
    
    lazy var textFieldView: QMUITextField = {
        let r = QMUITextField()
        r.tg_width.equal(.fill)
        r.tg_height.equal(INPUT_MEDDLE)
        r.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        r.textColor = .colorOnSurface
        
        //show the clear button when editing
        r.clearButtonMode = .whileEditing
        
        r.autocapitalizationType = .none
        return r
    }()
    
    lazy var textView: QMUITextView = {
        let r = QMUITextView()
        r.tg_width.equal(.fill)
        r.tg_height.equal(150)
        r.font = UIFont.systemFont(ofSize: TEXT_LARGE2)
        r.textColor = .colorOnSurface
        r.placeholderColor = .black80
        r.delegate = self
        
        r.autocapitalizationType = .none
        return r
    }()
    
    lazy var countView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.wrap)
        r.tg_height.equal(.wrap)
        r.font = UIFont.systemFont(ofSize: TEXT_SMALL)
        r.textColor = .black80
        r.text = "0/140"
        r.tg_right.equal(PADDING_MIDDLE)
        r.tg_bottom.equal(PADDING_MIDDLE)
        return r
    }()
}

extension SuperInputView{
    static func input(placeholder:String,image:UIImage?=nil) -> SuperInputView {
        let r = SuperInputView()
        r.initInput()
        
        if let image = image {
            r.iconView.show()
            r.iconView.image = image
        }
        
        r.textFieldView.placeholder = placeholder
        
        r.bottomBorder()
        
        return r
    }
    
    static func multiInput(placeholder:String,maxCount:Int = -1) -> SuperInputView {
        let r = SuperInputView()
        
        r.initMultiInput(maxCount)
        
        r.textView.placeholder = placeholder
        
        r.bottomBorder()
        
        return r
    }
    
    static func inputSmallBorder(placeholder:String) -> SuperInputView {
        let r = SuperInputView()
        
        r.initInput()
        
        r.textFieldView.placeholder = placeholder
        r.backgroundColor = .colorDivider
        r.smallBorder()
        
        return r
    }
}

//multi-line textView代理
extension SuperInputView:QMUITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if isCount() {
            let count = textView.text.count
            if count > maxCount && SuperStringUtil.isNotBlank(text) {
                //超出长度了
                //并且输入的内容不是删除按钮

                //不为空是过滤掉删除键
                //因为当按删除键时
                //内容就是空
                return false
            }
        }
        
        return true
    }
    
    /// 输入文本后回调
    func textViewDidChange(_ textView: UITextView) {
        if !isCount() {
            return
        }
        
        let count = textView.text.count
        countView.text = "\(count)/\(maxCount)"
    }
}
