//
//  EffectsConfiguration+Distortion.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation

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

