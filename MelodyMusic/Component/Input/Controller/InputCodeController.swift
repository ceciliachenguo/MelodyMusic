//
//  InputCodeController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/16/23.
//

import Foundation

class InputCodeController: BaseTitleController {
    var pageData: InputCodePageData!
    
    
}

extension InputCodeController{
    static func start(_ controller:UINavigationController,_ data:InputCodePageData) {
        let target = InputCodeController()
        target.pageData=data
        controller.pushViewController(target, animated: true)
    }
}
