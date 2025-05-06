//
//  IntakeSummaryView.swift
//  CalorieCam
//
//  Created by Michael Gibby on 5/5/25.
//


import SwiftUI

struct IntakeSummaryView: View {
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        VStack {
            Text("Calorie Intake Summary")
                .font(.title)
            Text("Daily Goal: \(userSettings.dailyCalorieGoal)")
            Text("Total Consumed: \(userSettings.totalCaloriesConsumed)")
            Text("Remaining: \(userSettings.dailyCalorieGoal - userSettings.totalCaloriesConsumed)")
        }
    }
}
