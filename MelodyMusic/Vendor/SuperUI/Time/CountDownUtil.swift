//
//  CountDownUtil.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 9/16/23.
//

import Foundation

class CountDownUtil {
    static var timer:DispatchSource?
    
    static func countDown(_ data: Int, callback:@escaping ((Int)->Void)){
        var timeout = data
       let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
       timer = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
        timer!.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
       //execute every second
       timer!.setEventHandler(handler: { () -> Void in
           timeout -= 1
           DispatchQueue.main.sync {
               callback(timeout)
           }
           
           if timeout == 0 {
               timer = nil
           }
       })
       timer!.resume()
    }
    
    static func cancel() {
        timer?.cancel()
        timer = nil
    }
}
