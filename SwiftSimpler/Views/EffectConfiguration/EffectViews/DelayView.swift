//
//  DelayView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 17.06.2022.
//

import SwiftUI

struct DelayView: View {
    @Binding var config: EffectsConfiguration.Delay
    
    let width: CGFloat

    var body: some View {
        HStack(spacing: 20) {
            KnobSegment(title: "Mix", parameter: $config.mix)
                .frame(width: width)
            KnobSegment(title: "Feedback", parameter: $config.feedback)
                .frame(width: width)
            KnobSegment(title: "LP Cutoff", parameter: $config.lowPassCutoff)
                .frame(width: width)
            KnobSegment(title: "Time", parameter: $config.time)
                .frame(width: width)
            
            Spacer()

            BypassToggle(isOn: $config.bypass)
                .frame(width: width)
            
        }
    
    }
}

