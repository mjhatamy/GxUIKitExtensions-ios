//
//  String+Extensions.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 3/8/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import CoreTelephony
import PhoneNumberKit

let TelephoneAlphabeticKeyPad = [
    "A":2,"B":2,"C":2,
    "D":3,"E":3,"F":3,
    "G":4,"H":4,"I":4,
    "J":5,"K":5,"L":5,
    "M":6,"N":6,"O":6,
    "P":7,"Q":7,"R":7,"S":7,
    "T":8,"U":8,"V":8,
    "W":9,"X":9,"Y":9,"Z":9
] as [Character:Int]

let CountryPhonePrefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]

extension NSMutableAttributedString {
    public func replaceOrSetAttributesWhereString(equal string:String,_ newAttributes:[NSAttributedString.Key: Any]) {
        if let range = self.string.range(of: string) {
            let nsrange = NSRange(range, in: self.string)
            for item in newAttributes {
                self.removeAttribute(item.key, range: nsrange)
            }
            self.addAttributes(newAttributes, range: nsrange)
        }
    }
    /*
    override public var appendNextLine:NSAttributedString {
        self.append(NSAttributedString(string: "\n"))
        return self
    }
    */
    public var appendNextLine:Void {
        let attributes:[NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.body]
        self.append(NSAttributedString(string: "\r\n", attributes: attributes))
    }
}

extension NSAttributedString {
    
    public func appendNextLine() -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        mutable.append(NSAttributedString(string: "\r\n"))
        return mutable
    }
    
}

fileprivate let PersianNumbers:[String:String] = [
    "0":"\u{0660}",//"۰",
    "1":"\u{0661}",//"۱",
    "2":"\u{0662}",//"۲",
    "3":"\u{0663}",//"۳",
    "4":"\u{0664}",//"۴",
    "5":"\u{0665}",//"۵",
    "6":"\u{0666}",//"۶",
    "7":"\u{0667}",//"۷",
    "8":"\u{0668}",//"۸",
    "9":"\u{0669}",//"۹",
    //"%":"\u{066A}", //٪
    //"*":"\u{066D}", //*
    //"+":"\u{0200F}+",
    //"$":"\u{0200E}$",
    //".":"\u{0200E}."
    ",":"،"
]

public extension String{
    static let phoneNumberKit = PhoneNumberKit()
    
    
    
    
    var embedExplicitLTR: String {
        return "\u{202A}" + self + "\u{202C}"
    }
    var localizeString: String {
        var value:String = self
        
        ///Clean up string from "\u{200E}" and "\u{200F}"
        value = value.replacingOccurrences(of: "\u{200E}", with: "")
        value = value.replacingOccurrences(of: "\u{200F}", with: "")
        
        //var state:Int = 0
        if Locale.current.isPersianBasedLanguage {
            for item in PersianNumbers {
                value = value.replacingOccurrences(of: item.key, with: "\u{200E}"+item.value)
            }
        }
        
        return value
    }
    
    var toEnglishNumbers:String {
        var value = self
        for item in PersianNumbers {
            value = value.replacingOccurrences(of: item.value, with: item.key)
        }
        return "\u{200E}" + value
    }
    
    private func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        if self.count <= 1 {
            return
        }
        self = self.capitalizingFirstLetter()
    }
    var capitalizedFirstLetter: String {
        if self.count <= 1 {
            return self
        }
        return self.capitalizingFirstLetter()
    }
    
    func conformTo(regularExpression pattern: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive ) -> Bool {
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let numberOfMathces = regex?.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) ?? 0
        return numberOfMathces > 0
    }
    
    func attributedString( _ foregroundColor:UIColor, font:UIFont?, alignment:NSTextAlignment? = nil, headIndent:CGFloat = 4, backgroundColor:UIColor? = nil) -> NSAttributedString{
        var attributes:[NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = foregroundColor
        
        if let m_font:UIFont = font {
            attributes[NSAttributedString.Key.font] = m_font
        }
        
        if let m_alignment:NSTextAlignment = alignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = m_alignment
            //paragraphStyle.headIndent = headIndent
            //paragraphStyle.tabStops = [NSTextTab.init(textAlignment: .left, location: headIndent, options: [:])]
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        if let m_backgroundColor = backgroundColor {
            attributes[NSAttributedString.Key.backgroundColor] = m_backgroundColor
        }
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func attributedStringMutable( _ foregroundColor:UIColor, font:UIFont?, alignment:NSTextAlignment? = nil, headIndent:CGFloat = 4, backgroundColor:UIColor? = nil) -> NSMutableAttributedString{
        var attributes:[NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = foregroundColor
        
        if let m_font:UIFont = font {
            attributes[NSAttributedString.Key.font] = m_font
        }
        
        if let m_alignment:NSTextAlignment = alignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = m_alignment
            paragraphStyle.headIndent = headIndent
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        if let m_backgroundColor = backgroundColor {
            attributes[NSAttributedString.Key.backgroundColor] = m_backgroundColor
        }
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
    func attributedStringMutable( font:UIFont?, alignment:NSTextAlignment? = nil, headIndent:CGFloat = 4, backgroundColor:UIColor? = nil) -> NSMutableAttributedString{
        var attributes:[NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()
        
        if let m_font:UIFont = font {
            attributes[NSAttributedString.Key.font] = m_font
        }
        
        if let m_alignment:NSTextAlignment = alignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = m_alignment
            paragraphStyle.headIndent = headIndent
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        if let m_backgroundColor = backgroundColor {
            attributes[NSAttributedString.Key.backgroundColor] = m_backgroundColor
        }
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
    var digitsString:String{
        let expression = "[^0-9]"
        do{
            let regexp = try NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.caseInsensitive)
            return regexp.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange.init(location: 0, length: self.count) , withTemplate: "")
        }catch{
            return self
        }
    }
    
    var hasCountryCodePrefix:Bool{
        if self.hasPrefix("00") || self.hasPrefix("+") {
            return true
        }
        return false
    }
    
    /// Aspect Ratio is 7:6
    func flagImageByCountryCodeWith(_ width:CGFloat = 30) -> UIImage? {
        var height:CGFloat = (width * 7)/6
        func emojiFlagString() -> String? {
            var string = ""
            let country = self.uppercased()
            for uS in country.unicodeScalars {
                guard let scallar = UnicodeScalar(127397 + uS.value) else{
                    return nil
                }
                string += "\(scallar)"
            }
            return string
        }
        
        guard let flagEmojiCode = emojiFlagString() else{
            return nil
        }
        
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (flagEmojiCode as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: width)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    var alphabeticPhoneToDigitsConverter:String{
        var newNumber:String = ""
        for val in self.uppercased() {
            if let newVal = TelephoneAlphabeticKeyPad[val] {
                newNumber = "\(newNumber)\(newVal)"
            }else{ newNumber = "\(newNumber)\(val)" }
        }
        return newNumber
    }
    
    func toPhoneNumberInternationalFormat(_ countryDialingCode:Int? = nil, isoCountryCode:String?, removeLeadingPlus:Bool = true, numberFormat:PhoneNumberFormat = PhoneNumberFormat.international) -> String?{
        ///If length is not enought , ignore it
        if self.count <= 5 {
            return nil
        }
        var digitString = self.alphabeticPhoneToDigitsConverter.digitsString
        
        ///Replace starting 00 with +
        if !digitString.hasPrefix("+") {
            if digitString.hasPrefix("00") {
                digitString = digitString.deletingPrefix("00")
                ///remove all leading zeros
                while( digitString.hasPrefix("0") ){
                    digitString = digitString.deletingPrefix("0")
                }
                //digitString = "+\(digitString)"
            }else{
                ///remove all leading zeros
                while( digitString.hasPrefix("0")){
                    digitString = digitString.deletingPrefix("0")
                }
            }
        }else{
            
        }
       
        do {
            let m_phoneNumber = try String.phoneNumberKit.parse( digitString, withRegion: isoCountryCode ?? PhoneNumberKit.defaultRegionCode(), ignoreType: false )
            return String.phoneNumberKit.format(m_phoneNumber, toType: numberFormat)
        }catch{
            do{
                digitString = String(format: "+%@", digitString)
                let m_phoneNumber = try String.phoneNumberKit.parse( digitString, withRegion: isoCountryCode ?? PhoneNumberKit.defaultRegionCode() )
                return String.phoneNumberKit.format(m_phoneNumber, toType: numberFormat)
            }catch{
                // LOGE("Unable to format number:\(digitString)   -> Raw:\(self). error:\(error) isoCountryCode:\(isoCountryCode ?? "")")
            }
            
        }
        return digitString
        /*
        let phoneNumberKit = PhoneNumberKit()
        do {
            let m_phoneNumber = try phoneNumberKit.parse( digitString, withRegion: isoCountryCode ?? PhoneNumberKit.defaultRegionCode(), ignoreType: false )
            return phoneNumberKit.format(m_phoneNumber, toType: PhoneNumberFormat.international).deletingPrefix(removeLeadingPlus ? "+" : "")
        }catch{
            do {
                ///remove leading + in case of failure
                digitString = digitString.deletingPrefix("+")
                let m_phoneNumber = try phoneNumberKit.parse(  "+\(countryDialingCode ?? "")\(digitString)", withRegion: isoCountryCode ?? PhoneNumberKit.defaultRegionCode()  )
                LOGI("1---> Unable to format number:\(error) number:\(self) digitString:\(digitString)")
                return phoneNumberKit.format(m_phoneNumber, toType: PhoneNumberFormat.international).deletingPrefix(removeLeadingPlus ? "+" : "")
            }catch{
                LOGI("Unable to format number:\(error) number:\(self) :\(digitString)")
                return PartialFormatter().formatPartial(digitString).deletingPrefix(removeLeadingPlus ? "+" : "")
            }
        }
        */
    }
    
    var partialPhoneNumberFormatter : String {
        let m_partialFormatter = PartialFormatter()
        return m_partialFormatter.formatPartial(self)
    }
    
    func prettyPhoneNumberFormat(_ countryDialingCode:Int? = nil, isoCountryCode:String? = nil, removeLeadingPlus:Bool = false) -> String?{
        var phoneNumber = self //.toDigitsString()
        let hasCountryCode:Bool = phoneNumber.hasCountryCodePrefix
        ///If the country Code prefix is 00 , replace it with +
        if hasCountryCode {
            if phoneNumber.hasPrefix("00") { phoneNumber.removeFirst(2) }
            if phoneNumber.hasPrefix("+")  { phoneNumber.removeFirst(1) }
        }
        
        let countryDialingCodeString: String? = countryDialingCode == nil ? "" : String(format: "%d", countryDialingCode ?? -1)
        
        //let phoneNumberKit = LibPhoneNumberKit()
        do {
            let m_phoneNumber = try String.phoneNumberKit.parse( hasCountryCode ? phoneNumber : "+\(phoneNumber)", withRegion: isoCountryCode ?? PhoneNumberKit.defaultRegionCode() )
            
            return String.phoneNumberKit.format(m_phoneNumber, toType: PhoneNumberFormat.international).deletingPrefix(removeLeadingPlus ? "+" : "")
        }catch{
            do {
                let m_phoneNumber = try String.phoneNumberKit.parse(  "+\(countryDialingCodeString ?? "")\(phoneNumber)", withRegion: isoCountryCode ?? PhoneNumberKit.defaultRegionCode())
                LOGI("1---> Unable to format number:\(error) number:\(self)")
                return String.phoneNumberKit.format(m_phoneNumber, toType: PhoneNumberFormat.international).deletingPrefix(removeLeadingPlus ? "+" : "")
            }catch{
                LOGI("Unable to format number:\(error) number:\(self)")
                return PartialFormatter().formatPartial(phoneNumber).deletingPrefix(removeLeadingPlus ? "+" : "")
            }
        }
    }
}
