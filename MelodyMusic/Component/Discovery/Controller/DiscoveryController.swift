//
//  DiscoveryController.swift
//  Discovery Page
//
//  Created by Cecilia Chen on 7/27/23.
//

import UIKit
import SwiftEventBus
import Alamofire

class DiscoveryController: BaseMainController {

    override func initViews() {
        super.initViews()

        initTableViewSafeArea()
        
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
                
                self?.loadSplashAd()

            }.disposed(by: rx.disposeBag)
    }
    
    func loadSplashAd() {
        DefaultRepository.shared
            .splashAds()
            .subscribe {[weak self] data in
                self?.processSplashAd(data.data.data ?? [])
            } _: { data, error in
                return true
            }.disposed(by: rx.disposeBag)

    }
    
    func processSplashAd(_ data:[Ad]) {
        if data.count > 0 {
            prepareDownloadAd(data[0])
        } else {
            //获取广告信息,TODO 这样只能删除上一个广告,但没法删除全部,可以优化
            if let _ = PreferenceUtil.getSplashAd() {
                PreferenceUtil.setSplashAd(nil)
            }
        }
    }
    
    func prepareDownloadAd(_ data:Ad) {
        //保存
        PreferenceUtil.setSplashAd(data)
        
        //判断文件是否存在，如果存在就不下载
        let path = StorageUtil.adPath(data.icon)
        if SuperFileUtil.exists(path.path) {
            print("ad exist,skip downloaded \(data.icon!) \(path.path)")
            return
        }
        
        let reachability = Reachability(hostName: "www.ixuea.com")
        let reachabilityStatus = reachability!.currentReachabilityStatus()
        if reachabilityStatus == ReachableViaWiFi {
            SuperFileUtil.mkdirs(path.deletingLastPathComponent().path)
            
            //wifi
            downloadAd(data,path)
        }
    }
    
    func downloadAd(_ data: Ad, _ path: URL) {
        let destination: DownloadRequest.Destination = { _, _ in
            return (path, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(data.icon.absoluteURL(), to: destination).response { response in
            if response.error == nil, let filePath = response.fileURL?.path {
                print("ad downloaded success \(filePath)")
            }
        }
    }
    
    func processAdClick(_ data: Ad) {
        if let uri = data.uri {
            if uri.starts(with: "http") {
                SuperWebController.start(navigationController!,
                                         title: data.title,
                                         uri: data.uri)
            }
        }
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
        
        //登录点击事件
        NotificationCenter.default.addObserver(self, selector: #selector(toLoginClick(_:)), name: NSNotification.Name(Constants.EVENT_LOGIN_CLICK), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(prepareProcessAdClick(_:)), name:NSNotification.Name(rawValue: Constants.EVENT_BANNER_CLICK), object: nil)
    }
    
    @objc func prepareProcessAdClick(_ d:Notification) {
        let data = d.userInfo![Constants.DATA] as! Ad
        processAdClick(data)
    }
    
    @objc func toLoginClick(_ data:Notification) {
        toLogin()
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
        startMusicPlayerController()
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
        SheetDetailController.start(navigationController!, data.id)
    }
}


#Preview {
    DiscoveryController()
}
