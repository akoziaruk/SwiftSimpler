//
//  ReverbView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import SwiftUI

struct ReverbView: View {
    @Binding var reverb: EffectsConfiguration.Reverb

    var body: some View {
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
            BypassToggleView(isOn: $reverb.bypassed)
        }
        .padding()
    }
}
