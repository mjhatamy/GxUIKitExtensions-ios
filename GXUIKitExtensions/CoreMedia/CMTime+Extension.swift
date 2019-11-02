//
//  CMTime+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 10/7/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AVFoundation


extension CMTime {
    public func formattedDurationString(_ showMinutes:Bool = true, showHours:Bool = false) -> String {
        if self == .indefinite || self.isIndefinite {
            LOGE("CTime object value is indefinite")
            return ""
        }
        var stringArr:[String] = [String]()
        let elapsedSeconds = CMTimeGetSeconds(self)
        stringArr.append(String(format: "%02d", Int(elapsedSeconds.truncatingRemainder(dividingBy: 60)) ) )
        
        if showMinutes {
            stringArr.append(String(format: "%02d", Int(elapsedSeconds / 60)))
        }
        
        if showHours {
            stringArr.append(String(format: "%02d", Int(elapsedSeconds / 3600)))
        }
        return stringArr.reversed().joined(separator: ":")
    }
    
    public static func subtract(_ lhs: CMTime, _ rhs: CMTime) -> CGFloat {
         return CGFloat(CMTimeGetSeconds(lhs) / CMTimeGetSeconds(rhs))
    }
    
    /**
     Seconds as TimeInterval from CTime item.
     Returns 0 if CTime value is Infinite or NaN
     */
    public var timeIntervalSeconds:TimeInterval {
        let val = CMTimeGetSeconds(self)
        if val.isInfinite || val.isNaN { return 0 }
        return val
    }
    
    /**
     Seconds as Double from CTime item.
     Returns 0 if CTime value is Infinite or NaN
     */
    public var doubleSeconds:Int {
        let val = CMTimeGetSeconds(self)
        if val.isInfinite || val.isNaN { return 0 }
        return Int(val)
    }
}
