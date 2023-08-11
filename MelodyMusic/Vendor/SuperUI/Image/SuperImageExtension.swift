//
//  SuperImageExtension.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/11/23.
//

import UIKit

extension UIImage {
    
    func withTintColor() -> UIImage {
        let result = self.withRenderingMode(.alwaysTemplate)
        return result
    }
}
