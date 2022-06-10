//
//  DelayView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import SwiftUI

struct DelayView_OLD: View {
    @Binding var delay: EffectsConfiguration.Delay

    var body: some View {
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
