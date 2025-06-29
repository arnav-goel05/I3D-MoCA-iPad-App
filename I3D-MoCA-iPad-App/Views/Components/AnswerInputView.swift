//
//  AnswerInputView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//
import SwiftUI

struct AnswerInputView: View {
    let title: String
    @Binding var userInput: String
    let onSubmit: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            TextField(title, text: $userInput, onCommit: onSubmit)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .frame(minWidth: 200, idealWidth: 350, maxWidth: 500)

            Button(action: onSubmit) {
                HStack {
                    Image(systemName: "paperplane.fill")
                    Text("Send")
                }
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 2, y: 1)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, y: 3)
        )
        .padding(.horizontal)
    }
}

struct AnswerInputView_Previews: PreviewProvider {
    @State static var input = ""
    static var previews: some View {
        AnswerInputView(title: "Your Answer…", userInput: $input) {
            // Preview submit action
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
