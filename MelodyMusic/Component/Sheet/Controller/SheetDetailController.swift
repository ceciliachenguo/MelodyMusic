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
