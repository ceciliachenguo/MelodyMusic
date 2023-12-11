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
        
        datum.append(data)
        
        datum += data.songs ?? []
        
        tableView.reloadData()
    }
    
    func typeForItemAtData(_ data: Any) -> MyStyle {
        if data is Sheet {
            return .sheet
        }
        return .song
    }
}

extension SheetDetailController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datum[indexPath.row]
        
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
}

extension SheetDetailController {
    /// 启动方法
    static func start(_ controller:UINavigationController,_ id:String) {
        let target = SheetDetailController()
        target.id=id
        controller.pushViewController(target, animated: true)
    }
}
