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
        if self == .indefinite {
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
}
