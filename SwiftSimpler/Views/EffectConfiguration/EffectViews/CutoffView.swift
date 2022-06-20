//
//  CutoffView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 20.06.2022.
//

import SwiftUI

struct CutoffView: View {
    @Binding var configLPF: EffectsConfiguration.CutoffFilter
    @Binding var configHPF: EffectsConfiguration.CutoffFilter

    let itemWidth: CGFloat
    
    var body: some View {
        HStack {
            Spacer()

            KnobSegment(title: "LPF Freq", parameter: $configLPF.frequency)
                .frame(width: itemWidth)
            
            Spacer()

            BypassToggle(isOn: $configLPF.bypass)
                .frame(width: itemWidth)

            Spacer()

            KnobSegment(title: "HPF Freq", parameter: $configHPF.frequency)
                .frame(width: itemWidth)
            
            Spacer()

            BypassToggle(isOn: $configHPF.bypass)
                .frame(width: itemWidth)

            Spacer()
        }
    }
}
