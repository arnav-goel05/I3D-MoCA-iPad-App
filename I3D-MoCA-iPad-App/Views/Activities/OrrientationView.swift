//
//  OrrientationView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct OrientationView: View {
    @StateObject private var manager = TaskManager(total: 6)
    @EnvironmentObject var activityManager: ActivityManager

    private let tasks: [TaskItem] = [
        TaskItem(title: "Task 1", question: "What date is it today? (e.g. 1, 2)", imageOne: nil, imageTwo: nil),
        TaskItem(title: "Task 2", question: "What month is it today? (e.g. January, February)", imageOne: nil, imageTwo: nil),
        TaskItem(title: "Task 3", question: "What year is it today (e.g. 2001, 2002)", imageOne: nil, imageTwo: nil),
        TaskItem(title: "Task 4", question: "What day is it today (e.g. Monday, Tuesday)", imageOne: nil, imageTwo: nil),
        TaskItem(title: "Task 5", question: "Where are you right now? (e.g. office, home)", imageOne: nil, imageTwo: nil),
        TaskItem(title: "Task 6", question: "What country are you in right now? (e.g. India, China)", imageOne: nil, imageTwo: nil)
    ]

    var body: some View {
        ZStack {
            manager.backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 40) {
                TaskHeaderView(title: "Orientation", subtitle: nil)

                Spacer()

                if manager.currentIndex >= tasks.count {
                    completionStage
                } else {
                    questionStage(for: tasks[manager.currentIndex])
                }

                Spacer()
            }
            .padding()
        }
    }

    // MARK: – Question Stage

    private func questionStage(for task: TaskItem) -> some View {
        VStack(spacing: 50) {
            Text("\(task.title): \(task.question)")
                .subtitleTextStyle()
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)

            AnswerInputView(
                title: "Type your answer…",
                userInput: $manager.userInput
            ) {
                manager.nextTask()
            }
        }
    }

    // MARK: – Completion Stage

    private var completionStage: some View {
        CompletionView(
            completionText: "🎉 You’re done!",
            buttonText: "Restart Assessment",
            onButtonTapped: {
                activityManager.nextActivity(index: 8)
            },
            destination: ContentView()
        )
    }
}

struct OrientationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OrientationView()
                .environmentObject(ActivityManager())
        }
    }
}
