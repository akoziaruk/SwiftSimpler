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
                    // sequence position view
                    SequencePositionView(length: $conductor.data.playback.length,
                                         position: conductor.position)
                        .frame(width: 35)
                    
                    // sequence / pads container
                    PadsContainerView(activeTrack: $activeTrack,
                                      padsViewState: $padsViewState,
                                      trackSelectionActive: $trackSelectionActive)

                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20))

            }
            .background(Palette.black)
            .statusBar(hidden: true)
        }
        
    }
}

struct SequencerPadsView: View {
    var sequence: Sequence
    var length: Int
    
    var body: some View {
        VStack {
            SequenceLineView(sequence: Array(sequence[0..<16]),  active: length >= 1)
            SequenceLineView(sequence: Array(sequence[16..<32]), active: length >= 2)
            SequenceLineView(sequence: Array(sequence[32..<48]), active: length >= 3)
            SequenceLineView(sequence: Array(sequence[48..<64]), active: length >= 4)
        }
    }
}

struct SequenceLineView: View {
    var sequence: Sequence
    var active: Bool
    
    var body: some View {
        HStack {
            ForEach(0..<16, id: \.self) { index in
                SequecerPad(selected: sequence[index] != nil, accent: index%4 == 0)
            }
        }
        .opacity(active ? 1 : 0.3)
    }
}

struct SequecerPad: View {
    var selected: Bool
    var accent: Bool
    
    var body: some View {
        ZStack {
            // Border
            RoundedRectangle(cornerRadius: 12)
                .stroke(Palette.grey, lineWidth: 2)
            
//            // Selection
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(color)
        }
        .contentShape(Rectangle())

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
