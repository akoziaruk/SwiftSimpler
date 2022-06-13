//
//  EffectConfigurationView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.06.2022.
//

import SwiftUI

struct EffectConfigurationView: View {
    @Binding var activeEffect: EffectType

    var body: some View {
        activeView
            .modifier(RoundedInnerBorder(color: Palette.red))
    }
    
    @ViewBuilder
    var activeView: some View {
        switch activeEffect {
        case .reverb:
            ReverbView()
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
}

struct ReverbView: View {
    var body: some View {
        Color.clear
        //green.opacity(0.2)
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
