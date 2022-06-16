//
//  Parameter.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit

extension Parameter: Equatable { }

typealias Value = AUValue

struct Parameter {
    var value: Value
    var range: ClosedRange<Value>
}
