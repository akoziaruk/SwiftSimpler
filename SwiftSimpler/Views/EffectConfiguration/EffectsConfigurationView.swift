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
            HStack {
                VStack(spacing: 0) {
                    EffectConfigurationView(activeEffect: $activeEffect)
                    
                    EffectPickerView(selected: $activeEffect, all: $effect.order)
                        .offset(y: -2) // offset to overlay configuration view
                        .frame(height: context.size.height * 0.18)
                }
                .frame(width: context.size.width * 0.7)
                
                Spacer()
                
                OutputConfugurationView()
                    .frame(width: context.size.width * 0.2)
            }
        }
    }
}

struct EffectPickerView: View {
    @Binding var selected: EffectType
    @Binding var all: [EffectType]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(all, id: \.self) { effect in
                    Button {
                        selected = effect
                    } label: {
                        Text(effect.title)
                            .foregroundColor(Palette.white)
                            .font(.title2)
                    }
                    .frame(maxHeight: .infinity)
                    .padding([.trailing, .leading], 20)
                    .background((selected == effect) ? Palette.black: .clear)
                    .overlay(
                        EffectPickerRoundedBottomBorder()
                            .stroke(Palette.red, lineWidth: (selected == effect) ? 2 : 1)
                    )

            }
            Spacer()
        }
        .padding(.leading, 30)
    }
}
