//
//  EffectsConfiguration+Flanger.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 20.06.2022.
//

import Foundation
import DunneAudioKit

extension EffectsConfiguration.Flanger: Equatable { }

extension EffectsConfiguration {
    struct Flanger {
        var frequency = Parameter(value: 1, range: 0.1...10.0)
        var depth = Parameter(value: 0.25, range: 0...1)
        var feedback = Parameter(value: 0.0, range: -0.95...0.95)
        var mix = Parameter(value: 0.5, range: 0...1)
        var bypass = false
    }
}

extension Flanger {
    func update(with configuration: EffectsConfiguration.Flanger) {
        frequency = configuration.frequency.value
        depth = configuration.depth.value
        feedback = configuration.feedback.value
        dryWetMix = configuration.mix.value
        updateBypass(configuration.bypass)
    }
}
