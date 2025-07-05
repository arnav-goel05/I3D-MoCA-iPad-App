// MoCALanguageTest.swift - No Microphone Version
// MoCA Sentence Repetition - Manual Input Only

import SwiftUI

struct MoCALanguageTest: View {
    @State private var sentences = [
        "I only know that John is the one to help today.",
        "The cat always hid under the couch when dogs were in the room."
    ]

    @State private var currentSentenceIndex = 0
    @State private var userInput = ""
    @State private var feedback = ""
    @State private var score = 0

    var body: some View {
        VStack(spacing: 30) {
            Text("🗣️ MoCA Language Test")
                .font(.largeTitle)
                .bold()

            Text("Repeat this sentence:")
                .font(.title2)

            if currentSentenceIndex < sentences.count {
                Text(sentences[currentSentenceIndex])
                    .italic()
                    .padding()
            } else {
                Text("✅ Language Test Completed. Score: \(score)/\(sentences.count)")
                    .italic()
                    .padding()
            }

            TextField("Type what you repeated", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 300)

            Button("Submit") {
                checkAnswer()
            }
            .keyboardShortcut(.defaultAction)

            if !feedback.isEmpty {
                Text(feedback)
                    .font(.title2)
                    .foregroundColor(.blue)

                Button("Next") {
                    goToNextSentence()
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
        let target = sentences[currentSentenceIndex].lowercased()
        let user = userInput.lowercased()

        let similarity = stringSimilarity(a: target, b: user)

        if similarity > 0.8 {
            score += 1
            feedback = "✅ Great! You repeated the sentence correctly."
        } else {
            feedback = "❌ Try again. The sentence was: \"\(target)\""
        }
    }

    private func goToNextSentence() {
        currentSentenceIndex += 1
        userInput = ""
        feedback = ""

        if currentSentenceIndex >= sentences.count {
            feedback = "Language Test Completed. Score: \(score)/\(sentences.count)"
        }
    }

    private func stringSimilarity(a: String, b: String) -> Double {
        let aWords = a.split(separator: " ")
        let bWords = b.split(separator: " ")
        let matches = aWords.filter { bWords.contains($0) }.count
        return Double(matches) / Double(max(aWords.count, 1))
    }
}

struct MoCALanguageTest_Preview: PreviewProvider {
    static var previews: some View {
        MoCALanguageTest()
            .previewDevice("iPad Pro (11-inch)")
    }
}
