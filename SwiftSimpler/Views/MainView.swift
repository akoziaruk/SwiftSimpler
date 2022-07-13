//
//  MainView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 07.06.2022.
//

import SwiftUI
                
struct MainView: View {
    @EnvironmentObject var conductor: Conductor
    
    @State var activeTrack = 0
    @State var padsViewState = PadsViewState.sequencer
    @State var trackSelectionActive = false
    
    static let sequencerRowSpacing = 8 as CGFloat
    
    var body: some View {
        GeometryReader { context in
            VStack {
                HStack(alignment: .top) {
                    EffectsConfigurationView(effect: $conductor.samples[activeTrack].configuration)

                    ProjectButtonsView()
                        .padding(.leading, 50)
                }
                .frame(height: context.size.height * 0.3)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
                
                ControlButtonsContainer(state: $padsViewState,
                                        trackSelectionActive: $trackSelectionActive)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .frame(height: context.size.height * 0.16)
                
                
                HStack(spacing: 15) {
                    SequencePositionView(length: $conductor.playbackData.length,
                                         page: conductor.playbackData.page,
                                         spacing: MainView.sequencerRowSpacing)
                        .frame(width: 35)
                    
                    PadsContainerView(activeTrack: $activeTrack,
                                      padsViewState: $padsViewState,
                                      trackSelectionActive: $trackSelectionActive,
                                      spacing: MainView.sequencerRowSpacing)

                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20))

            }
            .background(Palette.black)
            .statusBar(hidden: true)
        }
        
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .previewDevice("iPad Pro (9.7-inch)")
                .environmentObject(Conductor())
            .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
