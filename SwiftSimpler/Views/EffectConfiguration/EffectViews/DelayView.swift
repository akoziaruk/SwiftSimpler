//
//  DelayView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 17.06.2022.
//

import SwiftUI

struct DelayView: View {
    @Binding var config: EffectsConfiguration.Delay
    
    let itemWidth: CGFloat

    var body: some View {
        HStack(spacing: 20) {
            Spacer()

            KnobSegment(title: "Mix", parameter: $config.mix)
                .frame(width: itemWidth)
            KnobSegment(title: "Feedback", parameter: $config.feedback)
                .frame(width: itemWidth)
            KnobSegment(title: "LP Cutoff", parameter: $config.lowPassCutoff)
                .frame(width: itemWidth)
            KnobSegment(title: "Time", parameter: $config.time)
                .frame(width: itemWidth)
            
            Spacer()

            BypassToggle(isOn: $config.bypass)
                .frame(width: itemWidth)
        }
    }
}

