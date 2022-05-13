//
//  EffectsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI
import AudioKit

struct EffectConfigurationView: View {
    @Binding var activeEffect: ActiveEffect
    @Binding var data: SimplerData
    var body: some View {
        VStack {
            switch activeEffect {
            case .distortion:
                DistortionView(distortion: $data.effects.distortion)
                
            case .delay:
                DelayView(delay: $data.effects.delay)
                
            case .reverb:
                ReverbView(reverb: $data.effects.reverb)
            }
        }
    }
}

struct DistortionView: View {
    @Binding var distortion: EffectsConfig.Distortion

    var body: some View {
        EffectTitleView(title: "Distortion")
        HStack {
            VStack {
                EffectParameterView(title: "Mix", parameter: $distortion.mix)
                EffectParameterView(title: "Decimation", parameter: $distortion.decimation)
                EffectParameterView(title: "Rounding", parameter: $distortion.rounding)
            }
            VStack {
                EffectParameterView(title: "Soft Clip", parameter: $distortion.softClip)
                EffectParameterView(title: "Mod Freq", parameter: $distortion.modFreq)
                EffectParameterView(title: "Decay", parameter: $distortion.decay)
            }
        }
        .padding()
    }
}

struct DelayView: View {
    @Binding var delay: EffectsConfig.Delay

    var body: some View {
        EffectTitleView(title: "Delay")
        HStack {
            VStack {
                EffectParameterView(title: "Mix", parameter: $delay.mix)
                EffectParameterView(title: "Low Pass Cutoff", parameter: $delay.lowPassCutoff)
                EffectParameterView(title: "Feedback", parameter: $delay.feedback)
            }
            VStack {
                EffectParameterView(title: "Time", parameter: $delay.time)
                Spacer()
            }
        }
        .padding()
    }
}

struct ReverbView: View {
    @Binding var reverb: EffectsConfig.Reverb

    var body: some View {
        EffectTitleView(title: "Reverb")
        HStack {
            VStack {
                EffectParameterView(title: "Mix", parameter: $reverb.mix)
                EffectParameterView(title: "Crossover Frequency", parameter: $reverb.crossoverFrequency)
                EffectParameterView(title: "Predelay", parameter: $reverb.predelay)
            }
            VStack {
                EffectParameterView(title: "Release Time", parameter: $reverb.midReleaseTime)
                EffectParameterView(title: "Damping", parameter: $reverb.dampingFrequency)
                EffectParameterView(title: "Equalizer", parameter: $reverb.equalizerFrequency)
            }
        }
        .padding()
    }
}

struct EffectParameterView: View {
    var title: String
    @Binding var parameter: Parameter
    var body: some View {
        HStack {
            Text(title)
            Slider(value: $parameter.value, in: parameter.range)
        }
    }
}
