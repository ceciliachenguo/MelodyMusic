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
