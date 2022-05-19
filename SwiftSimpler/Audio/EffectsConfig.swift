//
//  EffectsConfig.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import Foundation
import AVKit

struct Parameter {
    var value: AUValue
    var range: ClosedRange<AUValue>
}

struct EffectsConfig {
    var distortion = Distortion()
    var delay = Delay()
    var reverb = Reverb()
    
    struct Distortion {
        var rounding = Parameter(value: 10, range: 0...100)
        var decimation = Parameter(value: 10, range: 0...100)
        var softClip = Parameter(value: -6, range: -80...20)
        var modFreq = Parameter(value: 100, range: 0.5...8000)
        var decay = Parameter(value: 1, range: 0.1...50)
        var mix = Parameter(value: 50, range: 0...100)
    }

    struct Delay {
        var lowPassCutoff = Parameter(value: 15_000, range: 10...22_050)
        var feedback = Parameter(value: -30, range: -100...100)
        var time = Parameter(value: 0.05, range: 0...2)
        var mix = Parameter(value: 3, range: 0...100)
    }
    
    struct Reverb {
        var crossoverFrequency = Parameter(value: 200, range: 50...1000)
        var predelay = Parameter(value: 60, range: 10...100)
        var midReleaseTime = Parameter(value: 2, range: 1...8)
        var dampingFrequency = Parameter(value: 6_000, range: 1_500...47_000)
        var equalizerFrequency = Parameter(value: 310, range: 40...2_500)
        var mix = Parameter(value: 0.2, range: 0...1)
    }
}

extension EffectsConfig: Equatable {
    static func == (lhs: EffectsConfig, rhs: EffectsConfig) -> Bool {
        lhs.distortion == rhs.distortion &&
        lhs.delay == rhs.delay &&
        lhs.reverb == rhs.reverb
    }
}

extension Parameter: Equatable { }
extension EffectsConfig.Distortion: Equatable {}
extension EffectsConfig.Reverb: Equatable {}
extension EffectsConfig.Delay: Equatable {}
