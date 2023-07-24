//
//  DefaultReferenceUtil.swift
//  Default References: if Logged in, if showing On-Boarding page, user ID
//
//  Created by Cecilia Chen on 7/24/23.
//

import Foundation

class DefaultPreferenceUtil {
    
    static func isAcceptTermsServiceAgreement() -> Bool {
        return UserDefaults.standard.bool(forKey: TERMS_SERVICE)
    }
    
    static func setAcceptTermsServiceAgreement(_ data:Bool) {
        UserDefaults.standard.set(data, forKey: TERMS_SERVICE)
    }
    
    static let TERMS_SERVICE = "TERMS_SERVICE"
}
