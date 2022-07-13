//
//  BypassToggle.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 27.05.2022.
//

import SwiftUI

struct BypassToggleView: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle("Bypass", isOn: $isOn)
            .frame(width: 120)
            .padding()
    }
}
