//
//  ContentView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var activityManager: ActivityManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Text("Montreal Cognitive Assessment (MoCA)")
                    .titleTextStyle()

                NavigationLink(destination: HelpView()) {
                    Text("Start Test")
                        .buttonTextStyle()
                }
            }
            .padding()
            .navigationTitle("MoCA")
        }
    }
}
