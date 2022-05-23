//
//  EffectsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI
import AudioKit

struct EffectConfigurationView: View {
    @Binding var configuration: EffectsConfiguration
    @State var activeEffect = Effect.distortion
    
    var body: some View {
        VStack {
            switch activeEffect {
            case .distortion:
                DistortionView(distortion: $configuration.distortion)
                
            case .delay:
                DelayView(delay: $configuration.delay)
                
            case .reverb:
                ReverbView(reverb: $configuration.reverb)
            }
            
            EffectPickerView(selected: $activeEffect, all: $configuration.order)
        }
    }
}

struct DistortionView: View {
    @Binding var distortion: EffectsConfiguration.Distortion

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
    @Binding var delay: EffectsConfiguration.Delay

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
    @Binding var reverb: EffectsConfiguration.Reverb

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
