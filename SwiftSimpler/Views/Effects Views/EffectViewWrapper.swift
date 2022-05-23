//
//  EffectViewWrapper.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import SwiftUI

struct EffectViewWrapper: View {
    @EnvironmentObject var conductor: Conductor
    @Binding var selectedIndex: Int
        
    var body: some View {
        EffectConfigurationView(configuration: $conductor.effectsConfigurations[selectedIndex])
    }
}
