//
//  DefaultService.swift
//  Network API
//
//  Created by Cecilia Chen on 7/24/23.
//

import Foundation
import Moya

enum DefaultService {
    
    //Ads List
    case ads(position: Int)
    
    case sheets(size: Int)
    
    case register(data: User)
    
}

extension DefaultService:TargetType {
    var baseURL: URL {
        return URL(string: Config.ENDPOINT)!
    }
    
    var path: String {
        switch self {
        case .ads(_):
            return "v1/ads"
        case .sheets(_):
            return "v1/sheets"
        case .register(_):
            return "v1/users"
        default:
            fatalError("Default Service Path is inValid")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register(_):
            return .post
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .ads(let position):
            return ParamUtil.urlRequestParameters(["position":position])
        case .sheets(let size):
            return ParamUtil.urlRequestParameters(["size":size])
//        case .register(let user):
//            return .requestPlain
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers:Dictionary<String, String> = [:]
        return headers
    }
    
}