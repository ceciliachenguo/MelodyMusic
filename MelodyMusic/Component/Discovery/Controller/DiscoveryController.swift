//
//  DiscoveryController.swift
//  Discovery Page
//
//  Created by Cecilia Chen on 7/27/23.
//

import UIKit

class DiscoveryController: BaseLogicController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableViewSafeArea()
    }
    
    override func initDatum() {
        super.initDatum()
        
        loadData()
    }
    
    func loadData() {
        DefaultRepository.shared
            .bannerAds()
            .subscribeSuccess { [weak self] data in
                self?.datum.removeAll()
                
                self?.datum.append(BannerData(data.data!.data!))
                
            }.disposed(by: rx.disposeBag)
    }
}
