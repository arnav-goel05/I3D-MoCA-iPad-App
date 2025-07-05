// AnimalTypingTest.swift - Manual Input Version
// Typing test for naming displayed animals

import SwiftUI

struct AnimalTypingTest: View {
    @State private var animals: [(name: String, image: String)] = [
        ("elephant", "elephant"),
        ("giraffe", "giraffe"),
        ("penguin", "penguin"),
        ("tiger", "tiger"),
        ("koala", "koala")
    ]

    @State private var currentIndex = 0
    @State private var userInput = ""
    @State private var feedback = ""
    @State private var score = 0

    var body: some View {
        VStack(spacing: 30) {
            Text("🦁 Animal Typing Test")
                .font(.largeTitle)
                .bold()

            if currentIndex < animals.count {
                Image(animals[currentIndex].image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)

                TextField("Type the name of the animal", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 300)

                Button("Submit") {
                    checkAnswer()
                }
                .keyboardShortcut(.defaultAction)
            } else {
                Text("✅ Animal Test Completed. Score: \(score)/\(animals.count)")
                    .font(.title2)
            }

            if !feedback.isEmpty {
                Text(feedback)
                    .font(.title2)
                    .foregroundColor(.blue)

                if currentIndex < animals.count {
                    Button("Next") {
                        goToNext()
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .cornerRadius(16)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func checkAnswer() {
        let expected = animals[currentIndex].name.lowercased()
        let actual = userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        if expected == actual {
            score += 1
            feedback = "✅ Correct!"
        } else {
            feedback = "❌ That was a \(actual). The correct answer is \(expected)."
        }
    }

    private func goToNext() {
        currentIndex += 1
        userInput = ""
        feedback = ""
    }
}

struct AnimalTypingTest_Preview: PreviewProvider {
    static var previews: some View {
        AnimalTypingTest()
            .previewDevice("iPad Pro (11-inch)")
    }
}
