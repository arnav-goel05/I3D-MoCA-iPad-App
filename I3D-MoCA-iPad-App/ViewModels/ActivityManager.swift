//
//  ActivityManager.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import Combine

final class ActivityManager: ObservableObject {
    @Published var currentActivityIndex: Int = 0

    func nextActivity(index: Int) {
        currentActivityIndex = index
    }
}
