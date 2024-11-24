//
//  ActivityTrackerApp.swift
//  ActivityTracker
//
//  Created by ednardo alves on 23/11/24.
//

import SwiftUI
import SwiftData

@main
struct ActivityTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ActivityTracker()
        }.modelContainer(for: Activity.self)
    }
}
