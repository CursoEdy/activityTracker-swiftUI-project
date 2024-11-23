//
//  ActivityTracker.swift
//  ActivityTracker
//
//  Created by ednardo alves on 23/11/24.
//

import SwiftUI
import Charts
import SwiftData

struct ActivityTracker: View {
    @Query(sort: \Activity.name, order: .forward)
    var activites: [Activity]
    
    @Environment(\.modelContext) private var contect
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("Activity Tracker")
            }
            .padding()
            .navigationTitle("Activity Tracker")
        }
    }
}

#Preview {
    ActivityTracker().modelContainer(for: Activity.self)
}
