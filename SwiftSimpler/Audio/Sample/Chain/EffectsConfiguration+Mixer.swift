//
//  EffectsConfiguration+Mixer.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit

extension EffectsConfiguration.Mixer: Equatable { }

extension EffectsConfiguration {
    struct Mixer {
        var volume = Parameter(value: 1, range: 0...5)
        var pan = Parameter(value: 0, range: -1...1)
    }
}

extension Mixer {
    func update(with configuration: EffectsConfiguration.Mixer) {
        volume = configuration.volume.value
        pan = configuration.pan.value
    }
}
