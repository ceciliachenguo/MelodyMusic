//
//  BaseLogicController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/23/23.
//

import UIKit
import TangramKit

class BaseLogicController: BaseCommonController {
    
    var rootContainer:TGBaseLayout!
    
    var superHeaderContainer: TGBaseLayout!
    var superHeaderContentContainer: TGBaseLayout!
    
    var superFooterContainer: TGBaseLayout!
    var superFooterContentContainer: TGBaseLayout!
    
    var container:TGBaseLayout!
    
    var tableView:UITableView!
    
    var scrollView:UIScrollView!
    var contentContainer:TGBaseLayout!
    
    lazy var datum: [Any] = {
        var result: [Any] = []
        return result
    }()

  /// initialize RelativeLayout container，4 borders are within the safe area
    func initRelativeLayoutSafeArea() {
        initLinearLayout()
        
        //header
        initHeaderContainer()
        
        container = TGRelativeLayout()
        container.tg_width.equal(.fill)
        container.tg_height.equal(.fill)
        container.backgroundColor = .clear
        rootContainer.addSubview(container)
        
        initFooterContainer()
    }
    
    /// initialize LinearLayout container，4 borders are within the safe area
    func initLinearLayoutSafeArea() {
        initLinearLayout()
        
        //header
        initHeaderContainer()
         
        container = TGLinearLayout(.vert)
        container.tg_width.equal(.fill)
        container.tg_height.equal(.fill)
        container.backgroundColor = .clear
        rootContainer.addSubview(container)
        
        initFooterContainer()
    }
    
    func initLinearLayout() {
        rootContainer = TGLinearLayout(.vert)
        rootContainer.tg_width.equal(.fill)
        rootContainer.tg_height.equal(.fill)
        rootContainer.backgroundColor = .clear
        view.addSubview(rootContainer)
    }
    
    //header container is beyond safe area, usually used to set background color that is beyond safe area
    func initHeaderContainer() {
        superHeaderContainer = TGLinearLayout(.vert)
        superHeaderContainer.tg_width.equal(.fill)
        superHeaderContainer.tg_height.equal(.wrap)
        superHeaderContainer.backgroundColor = .clear
        
        superHeaderContentContainer = TGLinearLayout(.vert)
        superHeaderContentContainer.tg_height.equal(.wrap)
        superHeaderContentContainer.tg_leading.equal(TGLayoutPos.tg_safeAreaMargin)
        superHeaderContentContainer.tg_trailing.equal(TGLayoutPos.tg_safeAreaMargin)
        superHeaderContentContainer.tg_top.equal(TGLayoutPos.tg_safeAreaMargin)
        superHeaderContentContainer.backgroundColor = .clear
        
        superHeaderContainer.addSubview(superHeaderContentContainer)
        rootContainer.addSubview(superHeaderContainer)

    }
    
    func initFooterContainer() {
        superFooterContainer = TGLinearLayout(.vert)
        superFooterContainer.tg_width.equal(.fill)
        superFooterContainer.tg_height.equal(.wrap)
        superFooterContainer.backgroundColor = .clear
        
        superFooterContentContainer = TGLinearLayout(.vert)
        superFooterContentContainer.tg_height.equal(.wrap)
        superFooterContentContainer.tg_leading.equal(TGLayoutPos.tg_safeAreaMargin)
        superFooterContentContainer.tg_trailing.equal(TGLayoutPos.tg_safeAreaMargin)
        superFooterContentContainer.tg_bottom.equal(TGLayoutPos.tg_safeAreaMargin)
        superFooterContentContainer.backgroundColor = .clear
        
        superFooterContainer.addSubview(superFooterContentContainer)
        rootContainer.addSubview(superFooterContainer)
    }
    
    func initTableViewSafeArea() {
        initLinearLayoutSafeArea()
        createTableView()
        
        container.addSubview(tableView)
    }
    
    func initScrollSafeArea() {
        initLinearLayoutSafeArea()
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.tg_width.equal(.fill)
        scrollView.tg_height.equal(.fill)
        container.addSubview(scrollView)
        
        contentContainer = TGLinearLayout(.vert)
        contentContainer.tg_width.equal(.fill)
        contentContainer.tg_height.equal(.wrap)
        
        scrollView.addSubview(contentContainer)
    }
    
    func initLinearLayoutInputSafeArea() {
        initLinearLayoutSafeArea()
        
        container.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: 0, right: PADDING_OUTER)
        container.tg_space = PADDING_OUTER
    }
    
    func createTableView() {
        tableView = ViewFactoryUtil.tableView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// use default separator
    func initDefaultTableViewDivider() {
        tableView.separatorStyle = .singleLine
    }
    
    override func initViews() {
        super.initViews()
        
        //default background color
        setBackgroundColor(.colorBackground)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func finish() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 隐藏键盘

    /// 点击空白隐藏键盘
    func initTapHideKeyboard() {
        //点击空白，关闭键盘
        let g=UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))

        //设置成false表示当前控件响应后会传播到其他控件上
        //如果不设置为false，界面里面的列表控件可能无法响应点击事件
        g.cancelsTouchesInView = true

        //将触摸事件添加到当前view
        view.addGestureRecognizer(g)
    }

    @objc func tapClick(_ data:UITapGestureRecognizer) {
        hideKeyboard()
    }

    /// 隐藏键盘
    func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - TableView data source and delegate
extension BaseLogicController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
