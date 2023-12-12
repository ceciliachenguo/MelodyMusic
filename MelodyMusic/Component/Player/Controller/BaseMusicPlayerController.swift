//
//  BaseMusicPlayerController.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 12/11/23.
//

import UIKit

class BaseMusicPlayerController: BaseTitleController {
    func startMusicPlayerController() {
        //simple music player
        startController(SimplePlayerController.self)
    }
}
