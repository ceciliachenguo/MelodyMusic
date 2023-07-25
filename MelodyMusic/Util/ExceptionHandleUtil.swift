//
//  ExceptionHandleUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 7/25/23.
//

import Foundation
import Moya
import Alamofire

class ExceptionHandleUtil {
    
    static func handlerResponse(_ data:BaseResponse?=nil, _ error:Error?=nil) {
        if error != nil {
            handleError(error!)
        } else {
            if let r = data?.message {
                SuperToast.show(title: r)
            } else {
                SuperToast.show(title: R.string.localizable.errorUnknown())
            }
        }
    }
    
    static func handleError(_ error:Error) {
        if let error = error as? MoyaError {
            switch error {
            case .stringMapping(_):
                SuperToast.show(title: "Cannot convert response to string")
            case .statusCode(let response):
                let code = response.statusCode
                handleHttpError(code)
            case .underlying(_, _):
                if let alamofireError = error.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError,
                   let underlyingError = alamofireError.underlyingError as? NSError {
                    switch underlyingError.code {
                    case NSURLErrorNotConnectedToInternet: //No internet
                        SuperToast.show(title: R.string.localizable.networkError())
                    case NSURLErrorTimedOut: //Internet too slow
                        SuperToast.show(title: R.string.localizable.errorNetworkTimeout())
                    case NSURLErrorCannotFindHost:
                        SuperToast.show(title: R.string.localizable.errorNetworkUnknownHost())
                    case NSURLErrorCannotConnectToHost:
                        SuperToast.show(title: R.string.localizable.errorNetworkUnknownHost())

                    default:
                        SuperToast.show(title: R.string.localizable.errorUnknown())
                    }
                } else {
                    SuperToast.show(title: R.string.localizable.errorUnknown())
                }
            default:
                SuperToast.show(title: R.string.localizable.errorUnknown())
            }
        }
    }
    
    static func handleHttpError(_ data:Int) {
        switch data {
        case 401:
            //login info expires
            SuperToast.show(title: R.string.localizable.errorNetworkNotAuth())
            AppDelegate.shared.logout()
        case 403:
            //no permission
            SuperToast.show(title: R.string.localizable.errorNetworkNotPermission())
        case 404:
            //resource couldn't found
            SuperToast.show(title: R.string.localizable.errorNetworkNotFound())
        case 500..<599:
            //server error
            SuperToast.show(title: R.string.localizable.errorNetworkServer())
        default:
            SuperToast.show(title: R.string.localizable.errorUnknown())
        }
    }
}
