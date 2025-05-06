//
//  ContentView 2.swift
//  CalorieCam
//
//  Created by Michael Gibby on 5/5/25.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CameraView()
                .tabItem {
                    Label("Camera", systemImage: "camera")
                }
            IntakeSummaryView()
                .tabItem {
                    Label("Summary", systemImage: "list.bullet")
                }
        }
    }
}
