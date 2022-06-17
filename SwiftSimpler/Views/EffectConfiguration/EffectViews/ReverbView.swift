//
//  ReverbView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 14.06.2022.
//

import SwiftUI

struct ReverbView: View {
    @Binding var config: EffectsConfiguration.Reverb
    
    let width: CGFloat
    
    var body: some View {
        HStack(spacing: 20) {
            KnobSegment(title: "Mix", parameter: $config.mix)
                .frame(width: width)
            KnobSegment(title: "Crossover", parameter: $config.crossoverFrequency)
                .frame(width: width)
            KnobSegment(title: "Damping", parameter: $config.dampingFrequency)
                .frame(width: width)
            KnobSegment(title: "Predelay", parameter: $config.predelay)
                .frame(width: width)
            KnobSegment(title: "Freq", parameter: $config.equalizerFrequency)
                .frame(width: width)
            KnobSegment(title: "Rls mid", parameter: $config.midReleaseTime)
                .frame(width: width)
            BypassToggle(isOn: $config.bypass)
                .frame(width: width)
        }
    }
}


