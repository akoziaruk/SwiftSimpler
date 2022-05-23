//
//  EffectsConfiguration+Reverb.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import SoundpipeAudioKit

extension EffectsConfiguration.Reverb: Equatable { }

extension EffectsConfiguration {
    struct Reverb {
        var crossoverFrequency = Parameter(value: 200, range: 50...1000)
        var predelay = Parameter(value: 60, range: 10...100)
        var midReleaseTime = Parameter(value: 2, range: 1...8)
        var dampingFrequency = Parameter(value: 6_000, range: 1_500...47_000)
        var equalizerFrequency = Parameter(value: 310, range: 40...2_500)
        var mix = Parameter(value: 0.2, range: 0...1)
    }
}

extension ZitaReverb {
    func update(with configuration: EffectsConfiguration.Reverb) {
        crossoverFrequency = configuration.crossoverFrequency.value
        predelay = configuration.predelay.value
        midReleaseTime = configuration.midReleaseTime.value
        dampingFrequency = configuration.dampingFrequency.value
        equalizerFrequency1 = configuration.equalizerFrequency.value
        dryWetMix = configuration.mix.value
    }
}
