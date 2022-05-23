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
    var order: [Effect] = [.distortion, .delay, .reverb]
    var distortion = Distortion()
    var delay = Delay()
    var reverb = Reverb()
    var mixer = Mixer()
}
