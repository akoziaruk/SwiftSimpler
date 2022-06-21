//
//  DistortionView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 20.06.2022.
//

import SwiftUI

struct DistortionView: View {
    @Binding var config: EffectsConfiguration.Distortion
        
    var body: some View {
        HStack(spacing: 0) {
            KnobSegment(title: "Mix", parameter: $config.mix)
            KnobSegment(title: "Rounding", parameter: $config.rounding)
            KnobSegment(title: "Decimation", parameter: $config.decimation)
            KnobSegment(title: "SoftClip", parameter: $config.softClip)
            KnobSegment(title: "Freq", parameter: $config.modFreq)
            KnobSegment(title: "Decay", parameter: $config.decay)
            BypassToggle(isOn: $config.bypass)
        }
    }
}
