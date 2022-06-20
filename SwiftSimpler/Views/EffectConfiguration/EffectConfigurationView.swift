//
//  EffectConfigurationView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.06.2022.
//

import SwiftUI

struct EffectConfigurationView: View {
    @Binding var activeEffect: EffectType
    @Binding var effect: EffectsConfiguration
    
    var body: some View {
        GeometryReader { context in
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .modifier(RoundedInnerBorder(color: Palette.red))

                activeView(itemWidth: ((context.size.width - Constants.padding.leading) / Constants.maxNumberOfItems) - Constants.padding.leading)
                    .padding(Constants.padding)
            }
            .frame(maxWidth: context.size.width)
        }
    }
    
    @ViewBuilder
    func activeView(itemWidth: CGFloat) -> some View {
        switch activeEffect {
        case .reverb:
            ReverbView(config: $effect.reverb)
        case .delay:
            DelayView(config: $effect.delay, itemWidth: itemWidth)
        case .flanger:
            FlangerView(config: $effect.flanger, itemWidth: itemWidth)
        case .distortion:
            DistortionView(config: $effect.distortion)
        case .equalizer:
            EqualizerView(configEq1: $effect.equalizer1, configEq2: $effect.equalizer2)
        case .cutoff:
            CutoffView(configLPF: $effect.lpf, configHPF: $effect.hpf, itemWidth: itemWidth)
        }
    }
    
    private struct Constants {
        static let maxNumberOfItems = 7.0
        static let padding = EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20)
    }
}
