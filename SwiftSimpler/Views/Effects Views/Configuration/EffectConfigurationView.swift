//
//  EffectsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI

struct EffectConfigurationView: View {
    @Binding var configuration: EffectsConfiguration
    @State var activeEffect = Effect.distortion
    
    var body: some View {
        VStack {
            switch activeEffect {
            case .distortion:
                DistortionView(distortion: $configuration.distortion)
                
            case .delay:
                DelayView(delay: $configuration.delay)
                
            case .reverb:
                ReverbView(reverb: $configuration.reverb)
            }
            
            HStack {
                EffectPickerView(selected: $activeEffect, all: $configuration.order)
                MixerView(mixer: $configuration.mixer)
            }
        }
    }
}

struct MixerView: View {
    @Binding var mixer: EffectsConfiguration.Mixer

    var body: some View {
        HStack {
            EffectParameterView(title: "Pan", parameter: $mixer.pan)
            EffectParameterView(title: "Volume", parameter: $mixer.volume)
        }
    }
}
