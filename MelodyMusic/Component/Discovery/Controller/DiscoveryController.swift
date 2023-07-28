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
        tableView.register(DiscoveryButtonCell.self, forCellReuseIdentifier: DiscoveryButtonCell.IDENTITY_NAME)
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
                
                //MARK: - Arrange the vertical order of BannerView/Horizontal Scrollable Buttons/Vertical Lists
                self?.datum.append(BannerData(data.data!.data!))
                
                self?.datum.append(ButtonData())
                
                self?.tableView.reloadData()
                
            }.disposed(by: rx.disposeBag)
    }
    
    func processAdClick(_ data: Ad) {
        print("DiscoveryController processAdClick \(data.title)")
    }
    
    func typeForItemAtData(_ data: Any) -> MyStyle {
        if data is ButtonData {
            return .button
        }
        return .banner
    }
}

extension DiscoveryController{
    
    //return the cell in current index
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = datum[indexPath.row]
        
        //get cell type
        let type = typeForItemAtData(data)
        
        switch type {
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoveryButtonCell.IDENTITY_NAME, for: indexPath) as! DiscoveryButtonCell
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL, for: indexPath) as! BannerCell
            cell.bind(data as! BannerData)
            cell.bannerClick = {[weak self] data in
                self?.processAdClick(data)
            }
            return cell
            
        }
    }
}

#Preview {
    DiscoveryController()
}
