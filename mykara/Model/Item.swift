//
//  Item.swift
//  mykara
//
//  Created by Yo_4040 on 2025/04/07.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
