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
    
    var order: [EffectType] = [.reverb, .delay, .flanger, .distortion, .equalizer, .cutoff]
    
    var reverb = Reverb()
    var delay = Delay()
    var flanger = Flanger()
    var distortion = Distortion()
    
    var equalizer1 = Equalizer()
    var equalizer2 = Equalizer()
    
    var lpf = CutoffFilter(value: 20_000)
    var hpf = CutoffFilter(value: 12)
    
    var mixer = Mixer()
}
