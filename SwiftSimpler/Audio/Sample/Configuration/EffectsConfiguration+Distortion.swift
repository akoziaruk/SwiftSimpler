//
//  EffectsConfiguration+Distortion.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit

extension EffectsConfiguration.Distortion: Equatable { }

extension EffectsConfiguration {
    struct Distortion {
        var rounding = Parameter(value: 10, range: 0...100)
        var decimation = Parameter(value: 10, range: 0...100)
        var softClip = Parameter(value: -6, range: -80...20)
        var modFreq = Parameter(value: 100, range: 0.5...8000)
        var decay = Parameter(value: 1, range: 0.1...50)
        var mix = Parameter(value: 50, range: 0...100)
    }
}

extension Distortion {
    func update(with configuration: EffectsConfiguration.Distortion) {
        rounding = configuration.rounding.value
        decimation = configuration.decimation.value
        softClipGain = configuration.softClip.value
        ringModFreq1 = configuration.modFreq.value
        decay = configuration.decay.value
        finalMix = configuration.mix.value
    }
}
