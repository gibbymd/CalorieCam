//
//  FoodItem.swift
//  CalorieCam
//
//  Created by Michael Gibby on 5/5/25.
//


import Foundation

struct FoodItem: Identifiable {
    var id = UUID()
    var name: String
    var estimatedCalories: Double
    var portionSize: String
}
