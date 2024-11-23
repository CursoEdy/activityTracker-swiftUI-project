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
    
    @State private var newName: String = ""
    @State private var hoursPerDay: Double = 0
    @State private var currentActivity: Activity? = nil
    
    @State private var selectCount: Int?
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Chart{
                    
                    let isSelected: Bool = true
                    
                    ForEach(activites) {activite in
                        SectorMark(
                            angle: .value("Value", activite.HoursPerDay),
                            innerRadius: .ratio(0.6),
                            outerRadius: isSelected ? 1.0 : .ratio(0.95),
                            angularInset: 1
                        ).foregroundStyle(.red.opacity(0.5))
                            .cornerRadius(10)
                    }
                    
//                    SectorMark(
//                        angle: .value("Value", 5),
//                        innerRadius: .ratio(0.6),
//                        outerRadius: .ratio(0.95),
//                        angularInset: 1
//                    ).foregroundStyle(.red.opacity(0.5))
//                        .cornerRadius(10)
//                    SectorMark(
//                        angle: .value("Value", 2),
//                        innerRadius: .ratio(0.6),
//                        outerRadius: .ratio(0.95),
//                        angularInset: 1
//                    ).foregroundStyle(.green.opacity(0.5))
//                        .cornerRadius(10)
//                    SectorMark(
//                        angle: .value("Value", 10),
//                        innerRadius: .ratio(0.6),
//                        outerRadius: .ratio(1.0),
//                        angularInset: 1
//                    ).foregroundStyle(.blue.opacity(0.5))
//                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Activity Tracker")
        }
        
    }
}

#Preview {
    ActivityTracker().modelContainer(for: Activity.self)
}
