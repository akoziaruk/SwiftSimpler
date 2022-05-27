//
//  FlangerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 26.05.2022.
//

import SwiftUI

struct FlangerView: View {
    @Binding var flanger: EffectsConfiguration.Flanger

    var body: some View {
        HStack {
            VStack {
                EffectParameterView(title: "Mix", parameter: $flanger.dryWetMix)
                Spacer()
            }
            VStack {
                EffectParameterView(title: "Frequency", parameter: $flanger.frequency)
                EffectParameterView(title: "Depth", parameter: $flanger.depth)
                EffectParameterView(title: "Feedback", parameter: $flanger.feedback)
            }
            BypassToggleView(isOn: $flanger.bypassed)
        }
        .padding()
    }
}
