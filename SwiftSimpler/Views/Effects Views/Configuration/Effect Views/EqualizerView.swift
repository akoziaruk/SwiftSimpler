//
//  EqualizerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 26.05.2022.
//

import SwiftUI

struct EqualizationGroupView: View {
    @Binding var eq1: EffectsConfiguration.Equalizer
    @Binding var eq2: EffectsConfiguration.Equalizer
    @Binding var lpf: EffectsConfiguration.CutoffFilter
    @Binding var hpf: EffectsConfiguration.CutoffFilter

    var body: some View {
        HStack {
            CutoffView(cutoff: $lpf, text: "LPF")
            EqualizerView(equalizer: $eq1, text: "Band 1")
            EqualizerView(equalizer: $eq2, text: "Band 2")
            CutoffView(cutoff: $hpf, text: "HPF")
        }
    }
}

struct EqualizerView: View {
    @Binding var equalizer: EffectsConfiguration.Equalizer

    let text: String
    
    var body: some View {
        VStack {
            HStack {
                Text(text)
                BypassToggleView(isOn: $equalizer.bypassed)
            }
            EffectParameterView(title: "Freq", parameter: $equalizer.centerFrequency)
            EffectParameterView(title: "Width", parameter: $equalizer.bandwidth)
            EffectParameterView(title: "Gain", parameter: $equalizer.gain)
        }
    }
}

struct CutoffView: View {
    @Binding var cutoff: EffectsConfiguration.CutoffFilter

    let text: String
    
    var body: some View {
        VStack {
            BypassToggleView(isOn: $cutoff.bypassed)
            EffectParameterView(title: text, parameter: $cutoff.frequency)
            Spacer()
        }
    }
}
