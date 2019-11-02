//
//  TimeInterval+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 10/17/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit


extension TimeInterval {
    public func formattedDurationString(_ showMinutes:Bool = true, showHours:Bool = false) -> String {
        if self.isInfinite || self.isNaN {
            LOGE("CTime object value is indefinite")
            return ""
        }
        var stringArr:[String] = [String]()
        let elapsedSeconds = self// CMTimeGetSeconds(self)
        stringArr.append(String(format: "%02d", Int(elapsedSeconds.truncatingRemainder(dividingBy: 60)) ) )
        
        if showMinutes {
            stringArr.append(String(format: "%02d", Int(elapsedSeconds / 60)))
        }
        
        if showHours {
            stringArr.append(String(format: "%02d", Int(elapsedSeconds / 3600)))
        }
        return stringArr.reversed().joined(separator: ":")
    }
}
