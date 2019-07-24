//
//  CGFloat+Extensions.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 3/5/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

extension Double {
    public var toMinutesAndSecondsDurationString:String{
        let seconds = (Int(self) % 3600) % 60
        let minute = (Int(self) % 3600) / 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    public var callDurationString:String{
        let seconds = (Int(self) % 3600) % 60
        let minute = (Int(self) % 3600) / 60
        return String(format: "%02d:%02d", minute, seconds)
    }
}

extension Float {
    public var toMinutesAndSecondsDurationString:String{
        let seconds = (Int(self) % 3600) % 60
        let minute = (Int(self) % 3600) / 60
        return String(format: "%02d:%02d", minute, seconds)
    }
}

extension Int {
    public var toMinutesAndSecondsDurationString:String{
        let seconds = (Int(self) % 3600) % 60
        let minute = (Int(self) % 3600) / 60
        return String(format: "%d:%02d", minute, seconds)
    }
}

extension CGFloat{
    public enum ParsingError: Error {
        case Generic
    }
    
    public static func readCGFloat(_ index: inout UnsafePointer<UInt8>, end: UnsafePointer<UInt8>, separator: UInt8) throws -> CGFloat {
        let begin = index
        var seenPoint = false
        while index <= end {
            let c = index.pointee
            index = index.successor()
            
            if c == 46 { // .
                if seenPoint {
                    throw ParsingError.Generic
                } else {
                    seenPoint = true
                }
            } else if c == separator {
                break
            } else if !((c >= 48 && c <= 57) || c == 45 || c == 101 || c == 69) {
                throw ParsingError.Generic
            }
        }
        
        if index == begin {
            throw ParsingError.Generic
        }
        
        if let value = NSString(bytes: UnsafeRawPointer(begin), length: index - begin, encoding: String.Encoding.utf8.rawValue)?.floatValue {
            return CGFloat(value)
        } else {
            throw ParsingError.Generic
        }
    }
}
