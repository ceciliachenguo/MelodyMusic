//
//  DefaultRepository.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/25/23.
//

import Foundation
import Moya
import RxSwift
import HandyJSON

class DefaultRepository {
    static let shared = DefaultRepository()
    
    private var moyaProvider:MoyaProvider<DefaultService>!
    
    
    //Banner in Discovery Page
    func bannerAds() -> Observable<ListResponse<Ad>> {
        return moyaProvider
            .rx
            .request(.ads(position: VALUE0))
            .asObservable()
            .mapString()
            .mapObject((ListResponse<Ad>.self))
    }
    
    func sheets(size:Int) -> Observable<ListResponse<Sheet>> {
        return moyaProvider
            .rx
            .request(.sheets(size: size))
            .asObservable()
            .mapString()
            .mapObject((ListResponse<Sheet>.self))
    }
    
    func sheetDetail(_ data:String) -> Observable<DetailResponse<Sheet>> {
        return moyaProvider
            .rx
            .request(.sheetDetails(data: data))
            .asObservable()
            .mapString()
            .mapObject((DetailResponse<Sheet>.self))
    }
    
    
    func songs() -> Observable<ListResponse<Song>> {
        return moyaProvider
                .rx
                .request(.songs)
                .asObservable()
                .mapString()
                .mapObject(ListResponse<Song>.self)
    }
    
    func songDetail(_ data:String) -> Observable<DetailResponse<Song>> {
        return moyaProvider
                .rx
                .request(.songDetail(data: data))
                .asObservable()
                .mapString()
                .mapObject(DetailResponse<Song>.self)
    }
    
    private init() {
        var plugins:[PluginType] = []
        
        if Config.DEBUG {
            plugins.append(NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose)))
        }
        
        //automatically show/hide toast loading warning according to Network Activity status
        let networkActivityPlugin = NetworkActivityPlugin { change, target in
            if change == .began {
                //start requesting
                let targetType = target as! DefaultService
                switch targetType {
                case .sheetDetails, .register:
                    DispatchQueue.main.async {
                        //to main thread
                        SuperToast.showLoading()
                    }
                default:
                    break
                }
            } else {
                //end request
                DispatchQueue.main.async {
                    SuperToast.hideLoading()
                }
            }
        }
                                                          
        plugins.append(networkActivityPlugin)
                                                          
        moyaProvider = MoyaProvider<DefaultService>(plugins: plugins)
    }
}
