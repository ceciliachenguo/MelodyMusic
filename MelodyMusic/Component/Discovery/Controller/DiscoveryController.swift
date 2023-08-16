//
//  DiscoveryController.swift
//  Discovery Page
//
//  Created by Cecilia Chen on 7/27/23.
//

import UIKit
import SwiftEventBus

class DiscoveryController: BaseLogicController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableViewSafeArea()
        
        tableView.register(BannerCell.self, forCellReuseIdentifier: Constants.CELL)
        tableView.register(DiscoveryButtonCell.self, forCellReuseIdentifier: DiscoveryButtonCell.IDENTITY_NAME)
        tableView.register(SheetGroupCell.self, forCellReuseIdentifier: SheetGroupCell.NAME)
        tableView.register(SongGroupCell.self, forCellReuseIdentifier: SongGroupCell.NAME)

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
                
                self?.loadSheetData()
                
            }.disposed(by: rx.disposeBag)
    }
    
    // Requesting discovery music sheet's data
    func loadSheetData() {
        DefaultRepository.shared
            .sheets(size: VALUE12)
            .subscribeSuccess {[weak self] data in
                self?.datum.append(SheetData(data.data!.data!))
                
                self?.loadSongData()
                
            }.disposed(by: rx.disposeBag)
    }
    
    func loadSongData() {
        DefaultRepository.shared.songs()
            .subscribeSuccess {[weak self] data in
                self?.datum.append(SongData(data.data!.data!))
                self?.tableView.reloadData()
            }.disposed(by: rx.disposeBag)
    }
    
    func processAdClick(_ data: Ad) {
        print("DiscoveryController processAdClick \(data.title)")
    }
    
    override func initListeners() {
        super.initListeners()
        SwiftEventBus.onMainThread(self, name: Constants.EVENT_SONG_CLICK) {[weak self] data in
            self?.processSongClick(data?.object as! Song)
        }
    }
    
    func processSongClick(_ data:Song) {
        print("DiscoveryController processSongClick \(data.title)")
    }
    
    func typeForItemAtData(_ data: Any) -> MyStyle {
        if data is ButtonData {
            return .button
        } else if data is SheetData {
            return .sheet
        } else if data is SongData {
            return .song
        }
        return .banner
    }
}

extension DiscoveryController{
    
    //return the cell in current index
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = datum[indexPath.row]
        let type = typeForItemAtData(data)
        
        switch type {
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoveryButtonCell.IDENTITY_NAME, for: indexPath) as! DiscoveryButtonCell
            cell.bind(data as! ButtonData)
            return cell
        case .sheet:
            let cell = tableView.dequeueReusableCell(withIdentifier: SheetGroupCell.NAME, for: indexPath) as! SheetGroupCell
            cell.bind(data as! SheetData)
            cell.delegate = self
            return cell
        case .song:
            let cell = tableView.dequeueReusableCell(withIdentifier: SongGroupCell.NAME, for: indexPath) as! SongGroupCell
            cell.bind(data as! SongData)
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

// 实现歌单组协议
extension DiscoveryController:SheetGroupDelegate{
    func sheetClick(data: Sheet) {
        print("SheetDetailController sheetClick \(data.title)")
    }
}


#Preview {
    DiscoveryController()
}
