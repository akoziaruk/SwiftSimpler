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
            activeView(itemWidth: context.size.width / CGFloat(Constants.maxNumberOfItems) - Constants.padding)
                .modifier(RoundedInnerBorder(color: Palette.red))
        }
    }
    
    @ViewBuilder
    func activeView(itemWidth: CGFloat) -> some View {
        switch activeEffect {
        case .reverb:
            ReverbView(config: $effect.reverb, itemWidth: itemWidth)
        case .delay:
            DelayView()
        case .flanger:
            FlangerView()
        case .distortion:
            DistortionView()
        case .equalizer:
            EqualizerView()
        }
    }
    
    private struct Constants {
        static let maxNumberOfItems = 7
        static let padding = 20.0
    }
}


struct DelayView: View {
    var body: some View {
        Color.blue.opacity(0.2)
    }
}

struct FlangerView: View {
    var body: some View {
        Color.purple.opacity(0.2)
    }
}

struct DistortionView: View {
    var body: some View {
        Color.orange.opacity(0.2)
    }
}

struct EqualizerView: View {
    var body: some View {
        Color.cyan.opacity(0.2)
    }
}
