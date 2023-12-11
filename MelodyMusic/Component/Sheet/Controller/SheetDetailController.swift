//
//  SheetDetailController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/10/23.
//

import UIKit

class SheetDetailController: BaseTitleController {
    
    var id:String!
    var data:Sheet!
    
    //背景
    var backgroundImageView: UIImageView!
    
    //背景模糊
    var backgroundVisual: UIVisualEffectView!
    
    override func initViews() {
        super.initViews()
        
        //添加背景图片控件
        backgroundImageView = UIImageView()
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        //背景模糊效果
        let blur = UIBlurEffect(style: .dark)
        backgroundVisual = UIVisualEffectView(effect: blur)
        backgroundImageView.addSubview(backgroundVisual)
        
        //初始化TableView结构
        initTableViewSafeArea()
                
        //设置状态栏为亮色(文字是白色)
        setStatusBarLight()
        
        setToolbarLight()
        
        title = R.string.localizable.sheet()
        
        //注册单曲
        tableView.register(SongCell.self, forCellReuseIdentifier: Constants.CELL)
        tableView.register(SheetInfoCell.self, forCellReuseIdentifier: SheetInfoCell.NAME)
        
        //注册section
        tableView.register(SongGroupHeaderView.self, forHeaderFooterViewReuseIdentifier: SongGroupHeaderView.NAME)
        tableView.bounces = false
    }

    override func initDatum() {
        super.initDatum()
        loadData()
    }
    
    func loadData() {
        DefaultRepository.shared
            .sheetDetail(id)
            .subscribeSuccess {[weak self] data in
                self?.show(data.data!)
            }.disposed(by: rx.disposeBag)
    }
    
    func show(_ data: Sheet) {
        self.data = data
        
        backgroundImageView.show(data.icon)
        UIView.animate(withDuration: 0.3) {
            //透明度设置为1
            self.backgroundImageView.alpha = 1
        }
        
        //first section
        var groupData = SongGroupData()
        groupData.datum = [data]
        datum.append(groupData)
        
        //second section
        if let r = data.songs {
            if !r.isEmpty {
                groupData=SongGroupData()
                groupData.datum = r
                datum.append(groupData)
                superFooterContainer.backgroundColor = .colorLightWhite
            }
        }
    
        tableView.reloadData()
    }
    
    func typeForItemAtData(_ data: Any) -> MyStyle {
        if data is Sheet {
            return .sheet
        }
        return .song
    }
    
    func play(_ data:Song) {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImageView.frame = view.bounds
        backgroundVisual.frame = backgroundImageView.bounds
    }
}

extension SheetDetailController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datum.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = datum[section] as! SongGroupData
        return data.datum.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //取出组数据
        let groupData=datum[section] as! SongGroupData
        
        //获取header
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SongGroupHeaderView.NAME) as! SongGroupHeaderView
        
        header.bind(groupData)
        
        header.playAllClick = {[weak self] in
            let groupData = self?.datum[1] as! SongGroupData
            self?.play(groupData.datum[0] as! Song)
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupData = datum[indexPath.section] as! SongGroupData
        let data = groupData.datum[indexPath.row]
        
        let type = typeForItemAtData(data)
        
        switch type {
        case .sheet:
            let cell = tableView.dequeueReusableCell(withIdentifier: SheetInfoCell.NAME, for: indexPath) as! SheetInfoCell
            cell.bind(data as! Sheet)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL, for: indexPath) as! SongCell
            cell.indexView.text = "\(indexPath.row + 1)"
            cell.bind(data as! Song)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    
}

extension SheetDetailController {
    /// 启动方法
    static func start(_ controller:UINavigationController,_ id:String) {
        let target = SheetDetailController()
        target.id=id
        controller.pushViewController(target, animated: true)
    }
}
