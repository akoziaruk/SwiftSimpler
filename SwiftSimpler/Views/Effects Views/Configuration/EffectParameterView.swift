//
//  EffectParameterView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import SwiftUI

struct EffectParameterView: View {
    var title: String
    @Binding var parameter: Parameter
    var body: some View {
        HStack {
            Text(title)
            Slider(value: $parameter.value, in: parameter.range)
        }
    }
}
