//
//  DistortionView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import SwiftUI

struct DistortionView: View {
    @Binding var distortion: EffectsConfiguration.Distortion

    var body: some View {
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
            BypassToggleView(isOn: $distortion.bypassed)
        }
        .padding()
    }
}
