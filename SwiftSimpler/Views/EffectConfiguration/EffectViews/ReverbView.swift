//
//  ReverbView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 14.06.2022.
//

import SwiftUI

struct ReverbView: View {
    @Binding var config: EffectsConfiguration.Reverb
        
    var body: some View {
        HStack(spacing: 0) {
            KnobSegment(title: "Mix", parameter: $config.mix)
            KnobSegment(title: "Crossover", parameter: $config.crossoverFrequency)
            KnobSegment(title: "Damping", parameter: $config.dampingFrequency)
            KnobSegment(title: "Predelay", parameter: $config.predelay)
            KnobSegment(title: "Freq", parameter: $config.equalizerFrequency)
            KnobSegment(title: "Rls mid", parameter: $config.midReleaseTime)
            BypassToggle(isOn: $config.bypass)
        }
    }
}


