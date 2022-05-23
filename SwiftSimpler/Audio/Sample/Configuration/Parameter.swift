//
//  Parameter.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit

extension Parameter: Equatable { }

struct Parameter {
    var value: AUValue
    var range: ClosedRange<AUValue>
}
