//
//  ActivityRowView.swift
//  ActivityTracker
//
//  Created by ednardo alves on 23/11/24.
//

import SwiftUI

struct ActivityRowView: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(activity.name)
                    .font(.headline)
                Text("\(activity.HoursPerDay.formatted()) hours per day")
            }
            Spacer()
        }
    }
}

#Preview {
    ActivityRowView(activity: .init(name: "Eat hummus", HoursPerDay: 3))
        .padding()
}
