//
//  MainController.swift
//  Main Page
//
//  Created by Cecilia Chen on 7/24/23.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .primaryColor
        tabBar.isTranslucent = true
        
        addChildController(DiscoveryController(), R.string.localizable.discovery(), "Discovery")
        addChildController(VideoController(), R.string.localizable.video(), "Video")
        addChildController(MeController(), R.string.localizable.me(), "Me")
        addChildController(FeedController(), R.string.localizable.feed(), "Feed")
        addChildController(RoomController(), R.string.localizable.live(), "Live")
    }

    func addChildController(_ target:UIViewController,_ title:String,_ imageName:String) {
        target.tabBarItem.title = title
        target.tabBarItem.image = UIImage(named: imageName)
        target.tabBarItem.selectedImage = UIImage(named: "\(imageName)Selected")
        target.tabBarItem.setBadgeTextAttributes([.foregroundColor:UIColor.colorPrimary], for: .selected)
        
        addChild(target)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("MainController didSelectItem \(item.title!)")
    }
}

#Preview {
    MainController()
}
