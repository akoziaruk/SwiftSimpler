//
//  MainView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 07.06.2022.
//

import SwiftUI
                
struct MainView: View {
    @EnvironmentObject var conductor: Conductor
    
    @State var selectedTrack = 0
    
    var body: some View {
        GeometryReader { context in
            VStack {
                HStack(alignment: .top) {
                    EffectsConfigurationView(effect: $conductor.samples[selectedTrack].configuration)

                    ProjectButtonsView()
                        .padding(.leading, 50)
                }
                .frame(height: context.size.height * 0.3)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
                
                
                
                
                // TODO: Implement
                //Control buttons container
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Palette.grey, lineWidth: 2)
                    )
                    .frame(height: context.size.height * 0.16)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                
                //Pads container
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Palette.grey, lineWidth: 2)
                    )
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))

            }
            .background(Palette.black)
            .statusBar(hidden: true)
        }
        
    }
}


struct OutputConfugurationView: View {
    var body: some View {
        Color.gray.opacity(0.2)
    }
}

struct ProjectButtonsView: View {
    var body: some View {
        Color.gray.opacity(0.2)
            .frame(width: 60)
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Conductor())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
