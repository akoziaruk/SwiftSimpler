//
//  EffectsUpdate.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit
import SoundpipeAudioKit

extension Distortion {
    func update(with configuration: EffectsConfig.Distortion) {
        rounding = configuration.rounding.value
        decimation = configuration.decimation.value
        softClipGain = configuration.softClip.value
        ringModFreq1 = configuration.modFreq.value
        decay = configuration.decay.value
        finalMix = configuration.mix.value
    }
}

extension ZitaReverb {
    func update(with configuration: EffectsConfig.Reverb) {
        crossoverFrequency = configuration.crossoverFrequency.value
        predelay = configuration.predelay.value
        midReleaseTime = configuration.midReleaseTime.value
        dampingFrequency = configuration.dampingFrequency.value
        equalizerFrequency1 = configuration.equalizerFrequency.value
        dryWetMix = configuration.mix.value
    }
}

extension Delay {
    func update(with configuration: EffectsConfig.Delay) {
        lowPassCutoff = configuration.lowPassCutoff.value
        feedback = configuration.feedback.value
        time = configuration.time.value
        dryWetMix = configuration.mix.value
    }
}
