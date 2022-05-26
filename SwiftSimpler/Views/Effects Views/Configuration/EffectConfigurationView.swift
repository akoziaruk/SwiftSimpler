//
//  EffectsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI

struct EffectConfigurationView: View {
    @State var activeEffect = EffectType.distortion
    @Binding var effect: EffectsConfiguration
    
    var body: some View {
        VStack {
            switch activeEffect {
            case .distortion:
                DistortionView(distortion: $effect.distortion)
                
            case .delay:
                DelayView(delay: $effect.delay)
                
            case .reverb:
                ReverbView(reverb: $effect.reverb)
                
            case .equalizer:
                EqualizationGroupView(eq1: $effect.equalizer1, eq2: $effect.equalizer2,
                                      lpf: $effect.lpfFilter, hpf: $effect.hpfFiler)
            }
            
            HStack {
                EffectPickerView(selected: $activeEffect, all: $effect.order)
                MixerView(mixer: $effect.mixer)
            }
        }
    }
}

