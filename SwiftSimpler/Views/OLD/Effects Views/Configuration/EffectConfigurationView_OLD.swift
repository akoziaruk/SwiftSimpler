//
//  EffectsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI

struct EffectConfigurationView_OLD: View {
    @State var activeEffect = EffectType.distortion
    @Binding var effect: EffectsConfiguration
    
    var body: some View {
        VStack {
            switch activeEffect {
            case .distortion:
                DistortionView_OLD(distortion: $effect.distortion)
                
            case .delay:
                DelayView_OLD(delay: $effect.delay)
                
            case .reverb:
                ReverbView_OLD(reverb: $effect.reverb)
                
            case .equalizer:
                EqualizationGroupView_OLD(eq1: $effect.equalizer1, eq2: $effect.equalizer2,
                                      lpf: $effect.lpfFilter, hpf: $effect.hpfFiler)
            case .flanger:
                ReverbView_OLD(reverb: $effect.reverb)

            }
            
            HStack {
                EffectPickerView_OLD(selected: $activeEffect, all: $effect.order)
                MixerView_OLD(mixer: $effect.mixer)
            }
        }
    }
}

