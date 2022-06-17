//
//  BypassToggle.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 17.06.2022.
//

import SwiftUI

struct BypassToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        GeometryReader { context in
            HStack {
                Spacer()
                
                VStack(spacing: 18) {

                    Text("Bypass")
                        .font(.headline)
                        .foregroundColor(Palette.white)

                    Toggle("", isOn: $isOn)
                        .labelsHidden()
                        .rotationEffect(Angle(degrees: -90))
                        .toggleStyle(SwitchToggleStyle(tint: Palette.red))
                        .frame(height: context.size.width)
                    
                }
                
                Spacer()
            }
        }
    }
}
