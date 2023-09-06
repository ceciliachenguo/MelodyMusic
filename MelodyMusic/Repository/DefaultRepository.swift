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
    
    private var provider:MoyaProvider<DefaultService>!
    
    
    //Banner in Discovery Page
    func bannerAds() -> Observable<ListResponse<Ad>> {
        return provider
            .rx
            .request(.ads(position: VALUE0))
            .asObservable()
            .mapString()
            .mapObject((ListResponse<Ad>.self))
    }
    
    func sheets(size:Int) -> Observable<ListResponse<Sheet>> {
        return provider
            .rx
            .request(.sheets(size: size))
            .asObservable()
            .mapString()
            .mapObject((ListResponse<Sheet>.self))
    }
    
    func sheetDetail(_ data:String) -> Observable<DetailResponse<Sheet>> {
        return provider
            .rx
            .request(.sheetDetails(data: data))
            .asObservable()
            .mapString()
            .mapObject((DetailResponse<Sheet>.self))
    }
    
    
    func songs() -> Observable<ListResponse<Song>> {
        return provider
                .rx
                .request(.songs)
                .asObservable()
                .mapString()
                .mapObject(ListResponse<Song>.self)
    }
    
    func songDetail(_ data:String) -> Observable<DetailResponse<Song>> {
        return provider
                .rx
                .request(.songDetail(data: data))
                .asObservable()
                .mapString()
                .mapObject(DetailResponse<Song>.self)
    }
    
    func register(_ data:User) -> Observable<DetailResponse<BaseModel>> {
        return provider
                    .rx
                    .request(.register(data: data))
                    .filterSuccessfulStatusCodes()
                    .mapString()
                    .asObservable()
                    .mapObject(DetailResponse<BaseModel>.self)
    }
    
    func login(_ data:User) -> Observable<DetailResponse<Session>> {
        return provider
                    .rx
                    .request(.login(data: data))
                    .filterSuccessfulStatusCodes()
                    .mapString()
                    .asObservable()
                    .mapObject(DetailResponse<Session>.self)
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
                                                          
        provider = MoyaProvider<DefaultService>(plugins: plugins)
    }
}
