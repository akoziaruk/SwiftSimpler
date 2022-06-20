//
//  EqualizerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 20.06.2022.
//

import SwiftUI

struct EqualizerView: View {
    @Binding var configEq1: EffectsConfiguration.Equalizer
    @Binding var configEq2: EffectsConfiguration.Equalizer
    
    @State var isBypassed: Bool
    
    init(configEq1: Binding<EffectsConfiguration.Equalizer>, configEq2: Binding<EffectsConfiguration.Equalizer>) {
        self._configEq1 = configEq1
        self._configEq2 = configEq2

        isBypassed = configEq1.bypass.wrappedValue || configEq2.bypass.wrappedValue
    }
    
    var body: some View {
        HStack(spacing: 20) {
            KnobSegment(title: "Freq 1", parameter: $configEq1.centerFrequency)
            KnobSegment(title: "Width 1", parameter: $configEq1.bandwidth)
            KnobSegment(title: "Gain 1", parameter: $configEq1.gain)
            
            KnobSegment(title: "Freq 2", parameter: $configEq2.centerFrequency)
            KnobSegment(title: "Width 2", parameter: $configEq2.bandwidth)
            KnobSegment(title: "Gain 2", parameter: $configEq2.gain)
            
            BypassToggle(isOn: $isBypassed)
        }
        .onChange(of: isBypassed) { newValue in
            configEq1.bypass = newValue
            configEq2.bypass = newValue
        }
    }
}
