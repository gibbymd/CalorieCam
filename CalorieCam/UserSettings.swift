//
//  UserSettings.swift
//  CalorieCam
//
//  Created by Michael Gibby on 5/5/25.
//


import Foundation

class UserSettings: ObservableObject {
    @Published var dailyCalorieGoal: Double = 2000
    @Published var totalCaloriesConsumed: Double = 0
}
