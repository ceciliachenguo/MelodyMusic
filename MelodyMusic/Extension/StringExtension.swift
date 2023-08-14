//
//  StringExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/14/23.
//

import Foundation

extension String {
    
    func absoluteURL() -> String {
        return "\(Config.RESOURCE_ENDPOINT)\(self)"
    }
}
