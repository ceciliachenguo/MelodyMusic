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
        moyaProvider = MoyaProvider<DefaultService>()
    }
    
}
