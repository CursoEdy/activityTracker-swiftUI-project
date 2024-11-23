//
//  ActivityModel.swift
//  ActivityTracker
//
//  Created by ednardo alves on 23/11/24.
//

import Foundation
import SwiftData

@Model
class Activity {
    @Attribute(.unique) var id = UUID().uuidString
    
    var name: String
    var HoursPerDay: Double
    
    init(id: String = UUID().uuidString, name: String, HoursPerDay: Double = 0.0) {
        self.id = id
        self.name = name
        self.HoursPerDay = HoursPerDay
    }
}
