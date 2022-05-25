//
//  Effect+Title.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation

extension EffectType {
    var title: String {
        switch self {
        case .distortion:   return "Distortion"
        case .delay:        return "Delay"
        case .reverb:       return"Reverb"
        }
    }
}
