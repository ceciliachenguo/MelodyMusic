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
    case sheetDetails(data: String)
    
    case register(data: User)
    case login(data: User)
    
    case songs
    case songDetail(data:String)
    
    case userDetail(data:String,nickname:String?)
    
    case sendCode(style:Int,data:CodeRequest)

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
        case .sheetDetails(let data):
            return "v1/sheets/\(data)"
            
        case .songs:
            return "v1/songs"
        case .songDetail(let data):
            return "v1/songs/\(data)"
            
        case .userDetail(let data,_):
            return "v1/users/\(data)"
            
        case .register(_):
            return "v1/users"
        case .login:
            return "v1/sessions"
            
        case .sendCode:
            return "v1/codes"
            
        default:
            fatalError("Default Service Path is inValid")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register(_), .login, .sendCode(_, _):
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
        case .login(let data):
            return .requestData(data.toJSONString()!.data(using: .utf8)!)
        case .userDetail(_, let nickname):
            var param:[String:Any]=[:]
            
            if let nickname = nickname {
                param["nickname"]=nickname
            }
            return ParamUtil.urlRequestParameters(param)
        case .register(let data):
            return .requestData(data.toJSONString()!.data(using: .utf8)!)
            
        case .sendCode(let style, let data):
            return .requestCompositeParameters(bodyParameters: ["phone":data.phone,"email":data.email], bodyEncoding: JSONEncoding.default, urlParameters: ["style":style])
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers:Dictionary<String, String> = [:]
        
        headers["Content-Type"] = "application/json"
        return headers
    }
    
}
