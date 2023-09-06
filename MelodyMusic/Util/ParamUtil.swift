//
//  ParamUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/24/23.
//

import Foundation
import Moya

class ParamUtil {
    static func urlRequestParameters(_ data:[String:Any]) -> Task {
        return .requestParameters(parameters: data, encoding: URLEncoding.default)
    }
    
    /// 返回JSON编码的参数
    ///
    /// - Parameter parameters: 要编码的参数
    /// - Returns: 编码后的Task
    static func jsonRequestParamters(_ parameters:[String:Any]) -> Task {
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
}
