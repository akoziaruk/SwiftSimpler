//
//  FlangerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 20.06.2022.
//

import SwiftUI

struct FlangerView: View {
    @Binding var config: EffectsConfiguration.Flanger
    
    let itemWidth: CGFloat
    
    var body: some View {
        HStack(spacing: 20) {
            KnobSegment(title: "Mix", parameter: $config.mix)
                .frame(width: itemWidth)

            KnobSegment(title: "Freq", parameter: $config.frequency)
                .frame(width: itemWidth)
            
            KnobSegment(title: "Depth", parameter: $config.depth)
                .frame(width: itemWidth)

            KnobSegment(title: "Feedback", parameter: $config.feedback)
                .frame(width: itemWidth)
            
            Spacer()

            BypassToggle(isOn: $config.bypass)
                .frame(width: itemWidth)
        }
    }
}
