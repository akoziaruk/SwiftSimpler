//
//  ReverbView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 14.06.2022.
//

import SwiftUI

struct ReverbView: View {
    @Binding var config: EffectsConfiguration.Reverb

    let itemWidth: CGFloat
    
    lazy var items = [("Mix", $config.mix)]

    var body: some View {
        HStack(spacing: 20) {
            
            KnobSegment(parameter: $config.mix,
                        title: "Mix")
//                .frame(width: itemWidth)

            KnobSegment(parameter: $config.crossoverFrequency,
                        title: "Crossover")
//                .frame(width: itemWidth)

            KnobSegment(parameter: $config.dampingFrequency,
                        title: "Damping")
//                .frame(width: itemWidth)

            KnobSegment(parameter: $config.predelay,
                        title: "Predelay")
//                .frame(width: itemWidth)

            KnobSegment(parameter: $config.equalizerFrequency,
                        title: "Freq")
//                .frame(width: itemWidth)

            KnobSegment(parameter: $config.midReleaseTime,
                        title: "Rls mid")
//                .frame(width: itemWidth)
            
            BypassToggle(isOn: $config.bypass)
//                .frame(width: itemWidth)

        }
        
        .padding(20)
    }
}


