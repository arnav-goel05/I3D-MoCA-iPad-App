//
//  AttentionView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct AttentionView: View {
    
    @StateObject private var manager = TaskManager(total: 7)
    @EnvironmentObject var activityManager: ActivityManager
    
    private let tasks: [TaskItem] = [
        TaskItem(title: "Task 1", question: "Here are some numbers, repeat them back in the same order.", imageOne: nil, imageTwo: nil),
        TaskItem(title: "Task 2", question: "Here are some more numbers, repeat them back in the backward order.", imageOne: nil, imageTwo: nil),
        TaskItem(title: "Task 3", question: "A sequence of numbers will be displayed. Tap the button 'Tap 1' each time you see the number 1. Do not select the button when you see a different number.", imageOne: nil, imageTwo: nil),
        TaskItem(title: "Task 4", question: "Count backward by 7's from 100 for 5 times and write those numbers down below. Do not include 100.", imageOne: nil, imageTwo: nil)
    ]
    
    let tappingOneNumList = [6, 2, 1, 3, 7, 8, 1, 1, 9, 7, 6, 2, 1, 6, 1, 7, 4, 5, 1, 1, 1, 9, 1, 7, 9, 6, 1, 1, 2]
    let subtractionNumList = [93, 86, 79, 72, 65]
    @State private var selectedIndices: Set<Int> = []
    @State private var taskThreeIndex = 0
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                manager.backgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    TaskHeaderView(title: "Attention", subtitle: nil)
                    
                    Spacer()
                    
                    if manager.currentIndex == 0 || manager.currentIndex == 2 || manager.currentIndex == 4 {
                        let task = tasks[manager.currentIndex / 2]
                        
                        Text(task.question)
                            .subtitleTextStyle()
                            .padding(50)
                        
                        if manager.currentIndex == 0 {
                            ZStack {
                                Text("2")
                                    .position(x: 250, y: 100)
                                    .subtitleTextStyle()
                                Text("1")
                                    .position(x: 350, y: 100)
                                    .subtitleTextStyle()
                                Text("8")
                                    .position(x: 450, y: 100)
                                    .subtitleTextStyle()
                                Text("5")
                                    .position(x: 550, y: 100)
                                    .subtitleTextStyle()
                                Text("4")
                                    .position(x: 650, y: 100)
                                    .subtitleTextStyle()
                            }
                            .frame(width: 900, height: 200)
                            .background(.blue.opacity(0.2))
                            .cornerRadius(30)
                        } else if manager.currentIndex == 2 {
                            ZStack {
                                Text("7")
                                    .position(x: 350, y: 100)
                                    .subtitleTextStyle()
                                Text("4")
                                    .position(x: 450, y: 100)
                                    .subtitleTextStyle()
                                Text("2")
                                    .position(x: 550, y: 100)
                                    .subtitleTextStyle()
                            }
                            .frame(width: 900, height: 200)
                            .background(.blue.opacity(0.2))
                            .cornerRadius(30)
                        }
                        
                        Button(action: {
                            manager.currentIndex += 1
                        }) {
                            Text("Proceed")
                                .buttonTextStyle()
                        }
                        .padding(.top, 50)
                        
                    } else if manager.currentIndex == 1 || manager.currentIndex == 3 || manager.currentIndex == 6 {
                        let questionIndex: Int = {
                                switch manager.currentIndex {
                                case 6:
                                    return manager.currentIndex / 2
                                case 1, 3:
                                    return (manager.currentIndex - 1) / 2
                                default:
                                    fatalError("Unexpected index")
                                }
                            }()
                        
                        let task = tasks[questionIndex]
                        
                        VStack (spacing: 40) {
                            if questionIndex == 0 {
                                Text("Enter the words previously shown in the same order.")
                                    .subtitleTextStyle()
                            } else if questionIndex == 1 {
                                Text("Enter the words previously shown in the backward order.")
                                    .subtitleTextStyle()
                            } else {
                                Text(task.question)
                                    .subtitleTextStyle()
                            }
                            AnswerInputView(title: "Type your answer…", userInput: $manager.userInput) {
                                manager.nextTask()
                            }
                        }
                    } else  if manager.currentIndex == 5 {
                        VStack(spacing: 40) {
                            Text(tasks[2].question)
                                .subtitleTextStyle()
                                .padding([.leading, .trailing], 50)

                            Text("\(tappingOneNumList[taskThreeIndex])")
                                .titleTextStyle()
                                .padding(50)

                            Button(action: {}) {
                                Text("Tap 1")
                                    .buttonTextStyle()
                            }
                        }
                        .onReceive(timer) { _ in
                            if taskThreeIndex < tappingOneNumList.count - 1 {
                                taskThreeIndex += 1
                            } else {
                                timer.upstream.connect().cancel()
                                manager.currentIndex += 1
                            }
                        }
                        .onAppear {
                            taskThreeIndex = 0
                            timer = Timer.publish(every: 1, on: .main, in: .common)
                                       .autoconnect()
                        }
                    } else {
                        CompletionView(
                            completionText: "🎉 You’re done!",
                            buttonText: "Next Task",
                            onButtonTapped: {
                                activityManager.nextActivity(index: 4)
                            },
                            destination: AbstractionView()
                        )
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Attention")
            }
        }
    }
}

struct AttentionView_Previews: PreviewProvider {
    static var previews: some View {
        AttentionView()
            .environmentObject(ActivityManager())
    }
}
