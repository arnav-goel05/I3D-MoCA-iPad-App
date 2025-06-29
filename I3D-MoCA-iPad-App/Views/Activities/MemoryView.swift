//
//  MemoryView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.

import SwiftUI

struct MemoryView: View {
    
    @EnvironmentObject var activityManager: ActivityManager
    @StateObject private var manager = TaskManager(total: 4)
    
    let listOfWords = "Face Silk Church Rose Red"
    
    var body: some View {
        NavigationStack {
            ZStack {
                manager.backgroundColor
                    .ignoresSafeArea()
                
                VStack (spacing: 50) {
                    
                    TaskHeaderView(title: "Memory", subtitle: nil)
                    
                    Spacer()
                    
                    if manager.currentIndex == 4 {
                        CompletionView(
                            completionText: "🎉 You’re done! Remember these 5 words, we will be asking them later on in the test.",
                            buttonText: "Next Task",
                            onButtonTapped: {
                                activityManager.nextActivity(index: 3)
                            },
                            destination: AttentionView()
                        )
                    } else if manager.currentIndex == 2 {
                        Text("Lets do it once again! Here are a list of words. Try your best to remember them all for now and later on in the test.")
                            .subtitleTextStyle()
                            .padding(20)
                        
                        ZStack {
                            Text("Face")
                                .position(x: 250, y: 100)
                                .subtitleTextStyle()
                            Text("Church")
                                .position(x: 450, y: 100)
                                .subtitleTextStyle()
                            Text("Red")
                                .position(x: 650, y: 100)
                                .subtitleTextStyle()
                            Text("Silk")
                                .position(x: 350, y: 200)
                                .subtitleTextStyle()
                            Text("Rose")
                                .position(x: 550, y: 200)
                                .subtitleTextStyle()
                        }
                        .frame(width: 900, height: 300)
                        .background(.blue.opacity(0.2))
                        .cornerRadius(30)
                        
                        Button(action: {
                            manager.currentIndex += 1
                        }) {
                            Text("Proceed")
                                .buttonTextStyle()
                        }
                    } else if manager.currentIndex == 1 || manager.currentIndex == 3 {
                        VStack (spacing: 40) {
                            Text("Enter the words previously shown in any order.")
                                .subtitleTextStyle()
                            
                            AnswerInputView(
                                title: "Type your answer…",
                                userInput: $manager.userInput
                            ) {
                                manager.nextTask()
                            }
                        }
                    } else {
                        Text("Here are a list of words. Try your best to remember them all for now and later on in the test.")
                            .subtitleTextStyle()
                            .padding(20)
                        
                        ZStack {
                            Text("Face")
                                .position(x: 250, y: 100)
                                .subtitleTextStyle()
                            Text("Church")
                                .position(x: 450, y: 100)
                                .subtitleTextStyle()
                            Text("Red")
                                .position(x: 650, y: 100)
                                .subtitleTextStyle()
                            Text("Silk")
                                .position(x: 350, y: 200)
                                .subtitleTextStyle()
                            Text("Rose")
                                .position(x: 550, y: 200)
                                .subtitleTextStyle()
                        }
                        .frame(width: 900, height: 300)
                        .background(.blue.opacity(0.2))
                        .cornerRadius(30)
                        
                        Button(action: {
                            manager.currentIndex += 1
                        }) {
                            Text("Proceed")
                                .buttonTextStyle()
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Memory")
            }
        }
    }
}

struct MemoryView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryView()
            .environmentObject(ActivityManager())
    }
}
