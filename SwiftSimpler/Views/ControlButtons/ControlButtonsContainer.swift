//
//  ControlButtonsContainer.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI
import CryptoKit

struct ControlButtonsContainer: View {
    var body: some View {
        HStack(spacing: 40) {
            BMPConfigurationView()
            PlayButton()
            Spacer()
            
        }
    }
}

