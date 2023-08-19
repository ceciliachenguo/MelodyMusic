//
//  DiscoveryController.swift
//  Discovery Page
//
//  Created by Cecilia Chen on 7/27/23.
//

import UIKit
import SwiftEventBus

class DiscoveryController: BaseTitleController {

    override func initViews() {
        super.initViews()
        setBackgroundColor(.colorBackgroundLight)

        initTableViewSafeArea()
        
        title = R.string.localizable.discovery()
        
        addLeftImageButton(R.image.menu()!)
        addRightImageButton(R.image.mic()!)
        
        toolbarView.addCenterView(searchButton)
        
        let header=MJRefreshNormalHeader {
            [weak self] in
            self?.loadData()
        }

        header.stateLabel?.isHidden = true

        header.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header=header

        
        tableView.register(BannerCell.self, forCellReuseIdentifier: Constants.CELL)
        tableView.register(DiscoveryButtonCell.self, forCellReuseIdentifier: DiscoveryButtonCell.IDENTITY_NAME)
        tableView.register(SheetGroupCell.self, forCellReuseIdentifier: SheetGroupCell.NAME)
        tableView.register(SongGroupCell.self, forCellReuseIdentifier: SongGroupCell.NAME)
        tableView.register(DiscoveryFooterCell.self, forCellReuseIdentifier: DiscoveryFooterCell.NAME)
    }
    
    func startRefresh() {
        tableView.mj_header!.beginRefreshing()
    }
    
    func endRefresh() {
        tableView.mj_header!.endRefreshing()
    }
    
    override func initDatum() {
        super.initDatum()
        
        startRefresh()
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
                self?.endRefresh()
                
                self?.datum.append(SongData(data.data!.data!))
                
                self?.datum.append(FooterData())
                
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
        SwiftEventBus.onMainThread(self, name: Constants.CLICK_EVENT) {[weak self] sender in
            let data = sender?.object as! MyStyle
            
            self?.processClick(data)
        }
    }
    
    func processClick(_ data:MyStyle) {
        switch data {
        case .refresh:
            autoRefresh()
        default:
            break
        }
    }
    
    func autoRefresh() {
        let indexPath = IndexPath(item: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {[weak self] in
            self?.startRefresh()
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
        } else if data is FooterData {
            return .footer
        }
        return .banner
    }
    
    lazy var searchButton:QMUIButton = {
        let r = QMUIButton()
        r.tg_width.equal(SCREEN_WIDTH - 50 * 2)
        r.tg_height.equal(35)
        r.adjustsTitleTintColorAutomatically = true
        r.tintColor = .black80
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.corner(17.5)
        r.setTitle(R.string.localizable.hintSearchValue(), for: .normal)
        r.setTitleColor(.black80, for: .normal)
        r.backgroundColor = .colorDivider
        r.setImage(R.image.search()!.withTintColor(), for: .normal)
        r.imagePosition = .left
        r.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: PADDING_SMALL)
        r.addTarget(self, action: #selector(searchClick(_:)), for: .touchUpInside)
        return r
    }()
    
    @objc func searchClick(_ sender: QMUIButton) {
        
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
        case .footer:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoveryFooterCell.NAME, for: indexPath)
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
//        print("SheetDetailController sheetClick \(data.title)")
        navigationController?.pushViewController(LoginHomeController())
    }
}


#Preview {
    DiscoveryController()
}
