//
//  DTMF.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 12/14/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public class DTMF {
    public typealias DTMFType = (Float, Float)
    //public typealias MarkSpaceType = (Float, Float)
    
    public enum MarkSpaceType: RawRepresentable {
        //public typealias RawValue = DTMFType
        case standard
        case motorola
        case whelen
        case fast
        case long
        
        public init?(rawValue: Self.RawValue) {
            return nil
        }
        
        public var rawValue: DTMF.DTMFType {
            switch self {
            case .standard:
                return DTMFType(40.0, 40.0)
            case .motorola:
                return DTMFType(250.0, 250.0)
            case .whelen:
                return DTMFType(40.0, 20.0)
            case .fast:
                return DTMFType(20.0, 20.0)
            case .long:
                return DTMFType(3000.0, 3000.0)
            }
        }
    }
    
    public static let tone1: DTMFType = DTMFType(1209.0, 697.0)
    public static let tone2: DTMFType = DTMFType(1336.0, 697.0)
    public static let tone3: DTMFType = DTMFType(1477.0, 697.0)
    public static let tone4: DTMFType = DTMFType(1209.0, 770.0)
    public static let tone5: DTMFType = DTMFType(1336.0, 770.0)
    public static let tone6: DTMFType = DTMFType(1477.0, 770.0)
    public static let tone7: DTMFType = DTMFType(1209.0, 852.0)
    public static let tone8: DTMFType = DTMFType(1336.0, 852.0)
    public static let tone9: DTMFType = DTMFType(1477.0, 852.0)
    public static let tone0: DTMFType = DTMFType(1336.0, 941.0)
    public static let toneStar: DTMFType = DTMFType(1209.0, 941.0)
    public static let tonePound: DTMFType = DTMFType(1477.0, 941.0)
    public static let toneA: DTMFType = DTMFType(1633.0, 697.0)
    public static let toneB: DTMFType = DTMFType(1633.0, 770.0)
    public static let toneC: DTMFType = DTMFType(1633.0, 852.0)
    public static let toneD: DTMFType = DTMFType(1633.0, 941.0)
/*
    public static let standard: DTMFType = MarkSpaceType(40.0, 40.0)
    public static let motorola: DTMFType = MarkSpaceType(250.0, 250.0)
    public static let whelen: DTMFType = MarkSpaceType(40.0, 20.0)
    public static let fast: DTMFType = MarkSpaceType(20.0, 20.0)
    public static let long: DTMFType = MarkSpaceType(3000.0, 3000.0)
    */
    /**
     Generates a series of Float samples representing a DTMF tone with a given mark and space.
     
        - parameter DTMF: takes a DTMFType comprised of two floats that represent the desired tone frequencies in Hz.
        - parameter markSpace: takes a MarkSpaceType comprised of two floats representing the duration of each in milliseconds. The mark represents the length of the tone and space the silence.
        - parameter sampleRate: the number of samples per second (Hz) desired.
        - returns: An array of Float that contains the Linear PCM samples that can be fed to AVAudio.
     */
    public static func generateDTMF(_ DTMF: DTMFType, markSpace: MarkSpaceType = .motorola, sampleRate: Float = 44100.0) -> [Float] {
        let toneLengthInSamples = 10e-4 * markSpace.rawValue.0 * sampleRate
        let silenceLengthInSamples = 10e-4 * markSpace.rawValue.1 * sampleRate

        var sound = [Float](repeating: 0, count: Int(toneLengthInSamples + silenceLengthInSamples))
        let twoPI: Float = 2.0 * .pi

        for i in 0 ..< Int(toneLengthInSamples) {
            // Add first tone at half volume
            let sample1 = 0.5 * sin(Float(i) * twoPI / (sampleRate / DTMF.0))

            // Add second tone at half volume
            let sample2 = 0.5 * sin(Float(i) * twoPI / (sampleRate / DTMF.1))

            sound[i] = sample1 + sample2
        }

        return sound
    }
}

extension DTMF {
    enum characterForTone: Character {
        case tone1     = "1"
        case tone2     = "2"
        case tone3     = "3"
        case tone4     = "4"
        case tone5     = "5"
        case tone6     = "6"
        case tone7     = "7"
        case tone8     = "8"
        case tone9     = "9"
        case tone0     = "0"
        case toneA     = "A"
        case toneB     = "B"
        case toneC     = "C"
        case toneD     = "D"
        case toneStar  = "*"
        case tonePound = "#"
    }

    public static func toneForCharacter(character: Character) -> DTMFType? {
        var tone: DTMFType?
        switch character {
        case characterForTone.tone1.rawValue:
            tone = DTMF.tone1
        case characterForTone.tone2.rawValue:
            tone = DTMF.tone2
        case characterForTone.tone3.rawValue:
            tone = DTMF.tone3
        case characterForTone.tone4.rawValue:
            tone = DTMF.tone4
        case characterForTone.tone5.rawValue:
            tone = DTMF.tone5
        case characterForTone.tone6.rawValue:
            tone = DTMF.tone6
        case characterForTone.tone7.rawValue:
            tone = DTMF.tone7
        case characterForTone.tone8.rawValue:
            tone = DTMF.tone8
        case characterForTone.tone9.rawValue:
            tone = DTMF.tone9
        case characterForTone.tone0.rawValue:
            tone = DTMF.tone0
        case characterForTone.toneA.rawValue:
            tone = DTMF.toneA
        case characterForTone.toneB.rawValue:
            tone = DTMF.toneB
        case characterForTone.toneC.rawValue:
            tone = DTMF.toneC
        case characterForTone.toneD.rawValue:
            tone = DTMF.toneD
        case characterForTone.toneStar.rawValue:
            tone = DTMF.toneStar
        case characterForTone.tonePound.rawValue:
            tone = DTMF.tonePound
        default:
            break
        }

        return tone
    }

    public static func tonesForString(_ string: String) -> [DTMFType]? {
        var tones = [DTMFType]()
        for character in string {
            if let tone = DTMF.toneForCharacter(character: character) {
                tones.append(tone)
            }
        }

        return tones.count > 0 ? tones : nil
    }
}

