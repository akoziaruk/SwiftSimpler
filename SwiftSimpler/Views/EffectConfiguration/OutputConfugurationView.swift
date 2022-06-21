//
//  OutputConfugurationView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 10.06.2022.
//

import SwiftUI

struct OutputConfugurationView: View {
    @Binding var config: EffectsConfiguration.Mixer
    
    var body: some View {
        VStack {
            Text("Output")
                .foregroundColor(Palette.white)
                .font(.headline)
                .padding(.top)
         
            HStack(spacing: 0) {
                KnobSegment(title: "Pan", parameter: $config.pan)
                KnobSegment(title: "Gain", parameter: $config.volume)
            }
            .padding([.leading, .trailing], 10)
        }
        .modifier(RoundedInnerBorder(color: Palette.red))
    }
}
