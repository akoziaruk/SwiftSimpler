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
        var frequency = Parameter(value: 1, range: 12.0...20_000.0)
        
        init(value: AUValue) {
            frequency.value = value
        }
    }
}

extension HighPassButterworthFilter {
    func update(with configuration: EffectsConfiguration.CutoffFilter) {
        cutoffFrequency = configuration.frequency.value
    }
}

extension LowPassButterworthFilter {
    func update(with configuration: EffectsConfiguration.CutoffFilter) {
        cutoffFrequency = configuration.frequency.value
    }
}
