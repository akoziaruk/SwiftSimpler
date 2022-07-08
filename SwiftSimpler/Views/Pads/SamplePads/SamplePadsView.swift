//
//  SamplePadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 08.07.2022.
//

import SwiftUI

struct SamplePadsView: View {
    var didSelected: (Int)->()

    var body: some View {
        VStack {
            // First row
            HStack {
                ForEach((1...4), id: \.self) { index in
                    SamplePad() {
                        didSelected(index-1)
                    }
                }
            }

            // Second row
            HStack {
                ForEach((5...8), id: \.self) { index in
                    SamplePad() {
                        didSelected(index-1)
                    }
                }
            }

        }
    }
}
