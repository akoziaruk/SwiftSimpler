//
//  EffectsConfiguration+Equalizer.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 26.05.2022.
//

import SoundpipeAudioKit

extension EffectsConfiguration.Equalizer: Equatable { }

extension EffectsConfiguration {
    struct Equalizer {
        var centerFrequency = Parameter(value: 100, range: 12.0...20_000.0)
        var bandwidth = Parameter(value: 100, range: 0...20_000.0)
        var gain = Parameter(value: 1, range: -20.0...20.0)
    }
}

extension EqualizerFilter {
    func update(with configuration: EffectsConfiguration.Equalizer) {
        centerFrequency = configuration.centerFrequency.value
        bandwidth = configuration.bandwidth.value
        gain = configuration.gain.value        
    }
}
