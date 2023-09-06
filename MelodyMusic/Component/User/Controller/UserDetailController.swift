//
//  UserDetailController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import UIKit

class UserDetailController: BaseTitleController {
    var id: String!
    var nickname: String?

}

extension UserDetailController{
    static func start(_ controller:UINavigationController, id:String="-1", nickname:String?=nil) {
        let target = UserDetailController()
        target.id=id
        target.nickname=nickname
        controller.pushViewController(target, animated: true)
    }
}
