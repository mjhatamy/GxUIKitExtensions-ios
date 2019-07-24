//
//  Date+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 4/5/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import Foundation

extension Date{
    
    public func getLongDateFormattedString(_ languageCode:String) -> String{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: languageCode)
        return dateFormatter.string(from: self)
    }
    
    /*
     This is a formatted string of call date.
     For Today Calls it displays time like 05:40 AM
     For Yesterday calls, returns "Yesterday"
     For Last 7 Days, It returns Week Days like "Sunday"
     For any days before last 7 days, It returns Date like 05/23/18  based on device locale (mm/dd/yy or dd/mm/yy)
     */
    public func recentCallDateFormattedString(_ languageCode:String, _ localizedStringForYesterday:String) -> String{
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: languageCode)
            return dateFormatter.string(from: self)
        }
        if calendar.isDateInYesterday(self) { return localizedStringForYesterday; }
        
        //NSLog("Date(timeIntervalSinceNow: -(60*24*7) ) :> \(Date(timeIntervalSinceNow: -(60*24*7) ))")
        if Date(timeIntervalSinceNow: -(60*24*7) ) < self && self < Date() {
            return self.getDayOfWeek(languageCode)
        }
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: languageCode)
        return dateFormatter.string(from: self)
    }
    
    public func getDayOfWeek(_ languageCode:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: languageCode)
        return dateFormatter.string(from: self).capitalized
    }
    
    public func getDayFormattedString(_ languageCode:String, _ localizedStringForToday:String, _ localizedStringForYesterday:String) -> String{
        let calendar = Calendar.current
        if calendar.isDateInToday(self) { return localizedStringForToday; }
        if calendar.isDateInYesterday(self) { return localizedStringForYesterday; }
        
        //NSLog("Date(timeIntervalSinceNow: -(60*24*7) ) :> \(Date(timeIntervalSinceNow: -(60*24*7) ))")
        if Date(timeIntervalSinceNow: -(60*24*7) ) < self && self < Date() {
            return self.getDayOfWeek(languageCode)
        }
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: languageCode)
        return dateFormatter.string(from: self)
    }
    
    
    public var hasPassedToday:Bool {
        /// Is Expired
        if self.timeIntervalSince1970 < Date().timeIntervalSince1970 {
            return true
        }
        return false
    }
    
    public var willPassInAWeek:Bool {
        if self.timeIntervalSince1970 < Date().timeIntervalSince1970 { /// Is Expired
            return true
        }
        /// One week till Expiration
        if self.timeIntervalSince1970 < Date().timeIntervalSince1970 + (7*24*60*60) /* One week*/ {
            return true
        }
        return false
    }
}
