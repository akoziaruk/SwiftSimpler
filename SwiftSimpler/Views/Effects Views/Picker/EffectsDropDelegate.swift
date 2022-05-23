//
//  EffectsDropDelegate.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 17.05.2022.
//

import SwiftUI


struct EffectsDropDelegate: DropDelegate {
    let item: Effect
    @Binding var items: [Effect]
    @Binding var draggedItem: Effect?
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedItem = draggedItem else {
            return
        }
        
        if item != draggedItem {
            let from = items.firstIndex(of: draggedItem)!
            let to = items.firstIndex(of: item)!
            items.move(fromOffsets: IndexSet(integer: from),
                       toOffset: to > from ? to + 1 : to)
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}

