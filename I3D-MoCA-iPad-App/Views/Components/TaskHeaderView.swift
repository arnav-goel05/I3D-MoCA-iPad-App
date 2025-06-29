//
//  TaskHeaderView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct TaskHeaderView: View {
    let title: String
    let subtitle: String?

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .titleTextStyle()
            if let subtitle = subtitle {
                Text(subtitle)
                    .subtitleTextStyle()
            }
        }
        .padding(20)
    }
}

struct TaskHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskHeaderView(title: "Sample Task", subtitle: "This is a subtitle")
                .previewLayout(.sizeThatFits)
            TaskHeaderView(title: "No Subtitle Task", subtitle: nil)
                .previewLayout(.sizeThatFits)
        }
    }
}
