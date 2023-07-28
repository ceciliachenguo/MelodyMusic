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
