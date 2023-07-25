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
