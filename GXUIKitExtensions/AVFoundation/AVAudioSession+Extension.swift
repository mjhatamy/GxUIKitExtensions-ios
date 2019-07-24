//
//  AVAudioSession+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 4/23/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AVFoundation

extension AVAudioSession {
    /**
     *  If there is a Bluetooth headset connected, this will return YES.
     */
    public var hasBluetooth:Bool {
        guard let availableInputs = self.availableInputs else{ return false }
        for input in availableInputs {
            if input.portType == AVAudioSession.Port.bluetoothHFP || input.portType == AVAudioSession.Port.bluetoothLE
                || input.portType == AVAudioSession.Port.usbAudio
                || input.portType == AVAudioSession.Port.carAudio || input.portType == AVAudioSession.Port.bluetoothA2DP{
                return true
            }
        }
        return false
    }
}
