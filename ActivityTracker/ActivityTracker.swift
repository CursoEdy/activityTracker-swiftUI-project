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
    var activities: [Activity]
    
    @Environment(\.modelContext) private var context
    
    @State private var newName: String = ""
    @State private var hoursPerDay: Double = 0
    @State private var currentActivity: Activity? = nil
    
    @State private var selectCount: Int?
    
    var totalHours: Double {
        var hours = 0.0
        for activity in activities {
            hours += activity.HoursPerDay
        }
        return hours
    }
    
    var remainingHours: Double {
        24 - totalHours
    }
    
    var maxHoursOfSelected: Double {
        remainingHours + hoursPerDay
    }
    
    let step = 1.0
    
    var body: some View {
        NavigationStack {
            VStack {
                if activities.isEmpty {
                    ContentUnavailableView("Enter an Activity", systemImage: "list.dash")
                } else {
                    Chart{
                                                
                        ForEach(activities) { activity in
                            let isSelected: Bool = currentActivity?.name == activity.name

                            SectorMark(
                                angle: .value("Activities", activity.HoursPerDay),
                                innerRadius: .ratio(0.6),
                                outerRadius: .ratio( isSelected ? 1.05 : 0.95),
                                angularInset: 1
                            ).foregroundStyle(by: .value("activity", activity.name))
                                .cornerRadius(10)
                                .opacity(isSelected ? 1 : 0.5)
                        }
                    }
                    .chartAngleSelection(value: $selectCount)
                }
                
                List{
                    ForEach(activities) { activity in
                        ActivityRowView(activity: activity)
                            .contentShape(Rectangle())
                            .listRowBackground(currentActivity?.name == activity.name ? Color.blue.opacity(0.2) : .clear)
                            .onTapGesture {
                                withAnimation {
                                    currentActivity = activity
                                    hoursPerDay = activity.HoursPerDay
                                }
                            }
                    }
                    .onDelete(perform: deleteActivity)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                
                //textfield
                TextField("Enter new activity", text: $newName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                
                // Slider
                if let currentActivity {
                    Slider(value: $hoursPerDay, in: 0...maxHoursOfSelected, step: step)
                        .onChange(of: hoursPerDay) { oldValue, newValue in
                            if let index = self.activities
                                .firstIndex(where: {$0.name == currentActivity.name}) {
                                activities[index].HoursPerDay = newValue
                            }
                        }
                }
                
                Button("Add") {
                    addActivity()
                }.buttonStyle(.borderedProminent).disabled(remainingHours <= 0)
                
            }
            .padding()
            .navigationTitle("Activity Tracker")
            .toolbar {
                EditButton().onChange(of: selectCount) { oldValue, newValue in
                    if let newValue {
                        withAnimation {
                            //change currentActivity based on newValue of selectCount
                            getSelected(value: newValue)
                        }
                    }
                }
            }
            
        }
        
    }
    
    private func addActivity() {
        if newName.count > 2 && !activities.contains(where: { $0.name.lowercased() == newName.lowercased() }) {
            // go ahead and add actitity
            
            // Reset hoursPerday
            hoursPerDay = 0
            
            let activity = Activity(name: newName, HoursPerDay: hoursPerDay)
            //add new activity
            context.insert(activity)
            
            //reset new activity
            newName = ""
            
            currentActivity = activity
        }
    }
    
    private func deleteActivity(at offsets: IndexSet) {
        offsets
            .forEach { index in
                let activity = activities[index]
                context.delete(activity)
            }
    }
    
    private func getSelected(value: Int) {
        //TODO: getSelected
        print(value)
        
    }
}

#Preview {
    ActivityTracker().modelContainer(for: Activity.self)
}
