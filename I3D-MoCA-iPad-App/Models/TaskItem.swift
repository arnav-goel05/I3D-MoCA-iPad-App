//
//  TaskItem.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import Foundation

struct TaskItem: Identifiable {
    let id = UUID()
    let title: String
    let question: String
    let imageOne: String?
    let imageTwo: String?
}
