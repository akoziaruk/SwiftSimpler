//
//  EqualizerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 26.05.2022.
//

import SwiftUI

struct EqualizationGroupView_OLD: View {
    @Binding var eq1: EffectsConfiguration.Equalizer
    @Binding var eq2: EffectsConfiguration.Equalizer
    @Binding var lpf: EffectsConfiguration.CutoffFilter
    @Binding var hpf: EffectsConfiguration.CutoffFilter

    var body: some View {
        HStack {
            CutoffView(cutoff: $lpf, text: "LPF")
            EqualizerView_OLD(equalizer: $eq1, text: "Band 1")
            EqualizerView_OLD(equalizer: $eq2, text: "Band 2")
            CutoffView(cutoff: $hpf, text: "HPF")
        }
    }
}

struct EqualizerView_OLD: View {
    @Binding var equalizer: EffectsConfiguration.Equalizer

    let text: String
    
    var body: some View {
        VStack {
            Text(text)
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
            EffectParameterView(title: text, parameter: $cutoff.frequency)
            Spacer()
        }
    }
}
