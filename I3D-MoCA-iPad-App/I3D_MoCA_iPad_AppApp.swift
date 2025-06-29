//
//  I3D_MoCA_iPad_AppApp.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

@main
struct I3D_MoCA_iPad_AppApp: App {
    @StateObject private var activityManager = ActivityManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(activityManager)
        }
    }
}
