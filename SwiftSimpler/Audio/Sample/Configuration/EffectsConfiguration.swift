//
//  EffectsConfig.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import Foundation
import AVKit

struct EffectsConfiguration {
    let id = UUID()
    
    var order: [EffectType] = [.distortion, .delay, .reverb, .equalizer]
    
    var distortion = Distortion()
    var delay = Delay()
    var reverb = Reverb()
    
    var equalizer1 = Equalizer()
    var equalizer2 = Equalizer()
    var lpfFilter = CutoffFilter(value: 20_000)
    var hpfFiler = CutoffFilter(value: 12)
    
    var mixer = Mixer()
}
