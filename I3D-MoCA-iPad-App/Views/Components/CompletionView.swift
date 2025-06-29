//
//  CompletionView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct CompletionView<Destination: View>: View {
    let completionText: String
    let buttonText: String
    let onButtonTapped: () -> Void
    let destination: Destination

    @State private var isPresented = false

    var body: some View {
        VStack(spacing: 50) {
            Text(completionText)
                .titleTextStyle()

            Button(action: {
                onButtonTapped()
                isPresented = true
            }) {
                Text(buttonText)
                    .buttonTextStyle()
            }
        }
        .padding()
        // Hidden navigation link
        .background(
            NavigationLink(
                destination: destination,
                isActive: $isPresented
            ) {
                EmptyView()
            }
        )
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CompletionView(
                completionText: "🎉 You're done!",
                buttonText: "Next",
                onButtonTapped: {},
                destination: Text("Next View")
            )
            .environmentObject(ActivityManager())
        }
        .previewLayout(.sizeThatFits)
    }
}
