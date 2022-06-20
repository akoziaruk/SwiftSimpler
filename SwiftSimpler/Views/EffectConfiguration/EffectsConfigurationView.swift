//
//  EffectsConfigurationView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.06.2022.
//

import SwiftUI

struct EffectsConfigurationView: View {
    @State var activeEffect: EffectType = .reverb
    @Binding var effect: EffectsConfiguration

    var body: some View {
        GeometryReader { context in
            HStack(alignment: .top) {
                VStack(spacing: 0) {
                    EffectConfigurationView(activeEffect: $activeEffect, effect: $effect)
                    
                    EffectPickerView(selected: $activeEffect, all: $effect.order)
                        .offset(y: -2) // offset to overlay configuration view
                        .frame(height: context.size.height * 0.18)
                }
                .frame(width: context.size.width * 0.7)
                
                Spacer()
                
                OutputConfugurationView(config: $effect.mixer)
                    .frame(width: context.size.width * 0.2,
                           height: context.size.height * 0.82)
            }
        }
    }
}

