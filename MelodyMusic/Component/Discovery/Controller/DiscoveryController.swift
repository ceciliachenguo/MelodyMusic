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
        
        tableView.register(BannerCell.self, forCellReuseIdentifier: Constants.CELL)
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
                
                self?.tableView.reloadData()
                
            }.disposed(by: rx.disposeBag)
    }
}

extension DiscoveryController{
    
    //return the cell in current index
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = datum[indexPath.row]
        
        //get a Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL, for: indexPath) as! BannerCell
        
        cell.bind(data as! BannerData)
        
        return cell
    }
}

#Preview {
    DiscoveryController()
}
