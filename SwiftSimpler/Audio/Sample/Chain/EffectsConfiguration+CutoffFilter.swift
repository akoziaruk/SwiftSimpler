//
//  EffectsConfiguration+CutoffFilter.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 26.05.2022.
//

import SoundpipeAudioKit
import AVKit

extension EffectsConfiguration.CutoffFilter: Equatable { }

extension EffectsConfiguration {
    struct CutoffFilter {
        var frequency = Parameter(value: 12.0, range: 12.0...20_000.0)
        var bypass = true
        
        init(value: AUValue) {
            frequency.value = value
        }
    }
}

extension HighPassButterworthFilter {
    func update(with configuration: EffectsConfiguration.CutoffFilter) {
        cutoffFrequency = configuration.frequency.value
        updateBypass(configuration.bypass)
    }
}

extension LowPassButterworthFilter {
    func update(with configuration: EffectsConfiguration.CutoffFilter) {
        cutoffFrequency = configuration.frequency.value
        updateBypass(configuration.bypass)
    }
}
