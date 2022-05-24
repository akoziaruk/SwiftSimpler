//
//  MixerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 24.05.2022.
//

import SwiftUI

struct MixerView: View {
    @Binding var mixer: EffectsConfiguration.Mixer

    var body: some View {
        HStack {
            EffectParameterView(title: "Pan", parameter: $mixer.pan)
            EffectParameterView(title: "Volume", parameter: $mixer.volume)
        }
    }
}
