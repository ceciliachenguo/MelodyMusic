//
//  PreferenceUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/6/23.
//

import Foundation
import MMKV

class PreferenceUtil {
    /// 设置用户Id
    static func setUserId(_ data:String) {
        MMKV.default()!.set(data, forKey: USER_ID)
    }

    /// 获取用户Id
    static func getUserId() -> String {
        return MMKV.default()!.string(forKey: USER_ID, defaultValue: Constants.ANONYMOUS)!
    }
    
    /// 设置用户session
    static func setSession(_ data:String) {
        MMKV.default()!.set(data, forKey: SESSION)
    }

    /// 获取用户session
    static func getSession() -> String {
        return MMKV.default()!.string(forKey: SESSION)!
    }
    
    /// 设置聊天session
    static func setChatSession(_ data:String) {
        MMKV.default()!.set(data, forKey: CHAT_SESSION)
    }

    /// 获取聊天session
    static func getChatSession() -> String {
        return MMKV.default()!.string(forKey: CHAT_SESSION)!
    }
    
    /// 是否登录了
    static func isLogin() -> Bool {
        return Constants.ANONYMOUS != getUserId()
    }
    
    /// 退出
    static func logout() {
        MMKV.default()!.removeValues(forKeys: [USER_ID,SESSION,CHAT_SESSION])
    }
    
    static func setSplashAd(_ data:Ad?) {
        if data == nil {
            MMKV.default()!.removeValue(forKey: SPLASH_AD)
        } else {
            MMKV.default()!.set(data!.toJSONString()!, forKey: SPLASH_AD)
        }
    }

    static func getSplashAd() -> Ad? {
        if let result = MMKV.default()!.string(forKey: SPLASH_AD) {
            return Ad.deserialize(from: result)
        }
        return nil
    }
    
    static func setLastPlaySongId(_ data:String) {
        MMKV.default()!.set(data, forKey: getLastPlaySongIdKey())
    }

    static func getLastPlaySongId() -> String? {
        return MMKV.default()!.string(forKey: getLastPlaySongIdKey())
    }
    
    private static func getLastPlaySongIdKey() -> String {
        return "\(LAST_PLAY_SONG_ID)\(getUserId())"
    }
    
    static func setUnplugHeadsetStopMusic(_ data:Bool) {
        MMKV.default()!.set(data, forKey: UNPLUG_HEADSET_STOP_MUSIC)
    }

    static func isUnplugHeadsetStopMusic() -> Bool {
        return MMKV.default()!.bool(forKey: UNPLUG_HEADSET_STOP_MUSIC, defaultValue: true)
    }
    
    static let TERMS_SERVICE = "TERMS_SERVICE"
    static let USER_ID = "USER_ID"
    static let SESSION = "SESSION"
    static let CHAT_SESSION = "CHAT_SESSION"
    static let LAST_PLAY_SONG_ID = "LAST_PLAY_SONG_ID"
    static let SPLASH_AD = "SPLASH_AD"
    static let UNPLUG_HEADSET_STOP_MUSIC = "UNPLUG_HEADSET_STOP_MUSIC"
}
