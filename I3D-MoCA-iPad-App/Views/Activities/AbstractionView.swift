//
//  AbstractionView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct AbstractionView: View {
    @StateObject private var manager = TaskManager(total: 2)
    @EnvironmentObject var activityManager: ActivityManager

    private let tasks: [TaskItem] = [
        TaskItem(title: "Task 1", question: "train - bicycle", imageOne: "train", imageTwo: "bicycle"),
        TaskItem(title: "Task 2", question: "watch - ruler", imageOne: "watch", imageTwo: "ruler")
    ]

    var body: some View {
        ZStack {
            manager.backgroundColor
                .ignoresSafeArea()

            VStack {
                header
                Spacer()
                content
                Spacer()
            }
            .padding()
        }
    }

    // MARK: – Header

    private var header: some View {
        TaskHeaderView(
            title: "Abstraction",
            subtitle: "Similarity between e.g. banana – orange = fruit"
        )
    }

    // MARK: – Main Content

    @ViewBuilder
    private var content: some View {
        if manager.currentIndex >= tasks.count {
            completionStage
        } else {
            taskStage(for: tasks[manager.currentIndex])
        }
    }

    // MARK: – Task Stage

    private func taskStage(for task: TaskItem) -> some View {
        VStack(spacing: 40) {
            imagePairView(for: task)
            AnswerInputView(
                title: "Type your answer…",
                userInput: $manager.userInput
            ) {
                manager.nextTask()
            }
        }
    }

    private func imagePairView(for task: TaskItem) -> some View {
        HStack(spacing: 35) {
            if let one = task.imageOne {
                VStack(spacing: 20) {
                    Image(one)
                        .imageStyle()
                    Text(one)
                        .regularTextStyle()
                }
            }
            if let two = task.imageTwo {
                VStack(spacing: 20) {
                    Image(two)
                        .imageStyle()
                    Text(two)
                        .regularTextStyle()
                }
            }
        }
        .padding(20)
    }

    // MARK: – Completion

    private var completionStage: some View {
        CompletionView(
            completionText: "🎉 You’re done!",
            buttonText: "Next Task",
            onButtonTapped: {
                activityManager.nextActivity(index: 6)
            },
            destination: DelayedRecallView()
        )
    }
}

struct AbstractionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AbstractionView()
                .environmentObject(ActivityManager())
        }
    }
}
