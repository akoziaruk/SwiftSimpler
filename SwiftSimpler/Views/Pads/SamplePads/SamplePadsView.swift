//
//  SamplePadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 08.07.2022.
//

import SwiftUI

struct SamplePadsView: View {
    var activeItemIndex: Int
    var didSelected: (Int)->()
    
    var body: some View {
        VStack {
            // First row
            HStack {
                ForEach((0...3), id: \.self) { index in
                    SamplePad(active: activeItemIndex == index) {
                        didSelected(index)
                    }
                }
            }

            // Second row
            HStack {
                ForEach((4...7), id: \.self) { index in
                    SamplePad(active: activeItemIndex == index) {
                        didSelected(index)
                    }
                }
            }

        }
    }
}
