//
//  ObservableMoyaExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/24/23.
//

import Foundation
import HandyJSON
import Moya
import RxSwift

public enum CustomizedError:Swift.Error {
    case objectMapping
}

extension Observable {
    
    func mapObject<T:HandyJSON>(_ type:T.Type) -> Observable<T> {
        map { data in
            guard let dataString = data as? String else {
                throw CustomizedError.objectMapping
            }
            
            guard let result = type.deserialize(from: dataString) else{
                throw CustomizedError.objectMapping
            }
            
            return result
        }
    }
}

public class HttpObserver<Element>:ObserverType {
    
    public typealias E = Element
    public typealias successCallBack = ((E) -> Void)
    
    var success:successCallBack
    var error:((BaseResponse?,Error?) -> Bool)?
    
    init(_ success:@escaping successCallBack, _ error:((BaseResponse?,Error?) -> Bool)? ) {
        self.success = success
        self.error = error
    }
    
    public func on(_ event: Event<Element>) {
        switch event {
        case .next(let data):
            print("HttpObserver next \(data)")
            let baseResponse = data as? BaseResponse
            
            if baseResponse?.status != 0 {
                //request error
                handleResponse(baseResponse: baseResponse)
            } else {
                success(data)
            }
        case .error(let error):
            print("HttpObserver error \(error)")
            handleResponse(error: error)
        case .completed:
            print("HttpObserver completed")
        }
    }
    
    func handleResponse(baseResponse:BaseResponse?=nil, error:Error?=nil) {
        if self.error != nil && self.error!(baseResponse, error) {
            
        } else {
            ExceptionHandleUtil.handlerResponse(baseResponse, error)
        }
    }
}

extension ObservableType {
    //MARK: - subscribe success & error
    func subscribe(_ success:@escaping ((Element)-> Void),_ error: @escaping ((BaseResponse?,Error?)-> Bool)) -> Disposable {
        let disposable = Disposables.create()
        let observer = HttpObserver<Element>(success,error)
        return Disposables.create(self.asObservable().subscribe(observer),disposable)
    }
    
    //MARK: - subscribe only when success
    func subscribeSuccess(_ success:@escaping ((Element) -> Void)) -> Disposable {
        
        let disposable = Disposables.create()
        let observer = HttpObserver<Element>(success, nil)
        return Disposables.create(self.asObservable().subscribe(observer),disposable)
    }
}
