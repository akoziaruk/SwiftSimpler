//
//  EffectsConfiguration+Delay.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit

extension EffectsConfiguration.Delay: Equatable { }

extension EffectsConfiguration {
    struct Delay {
        var lowPassCutoff = Parameter(value: 15_000, range: 10...22_050)
        var feedback = Parameter(value: -30, range: -100...100)
        var time = Parameter(value: 0.05, range: 0...2)
        var mix = Parameter(value: 3, range: 0...100)
        var bypass = false
    }
}

extension Delay {
    func update(with configuration: EffectsConfiguration.Delay) {
        lowPassCutoff = configuration.lowPassCutoff.value
        feedback = configuration.feedback.value
        time = configuration.time.value
        dryWetMix = configuration.mix.value
    }
}
