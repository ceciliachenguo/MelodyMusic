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
}
