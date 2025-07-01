//
//  Styles.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

// Styling for button text.
struct ButtonTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 35, weight: .semibold, design: .rounded))
            .frame(width: 300, height: 60)
            .padding()
            .cornerRadius(10)
    }
}

// Styling for large icon button text.
struct LargeIconButtonTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 45, weight: .semibold, design: .rounded))
            .frame(width: 350, height: 100)
            .padding()
            .cornerRadius(10)
    }
}

// Styling for title text.
struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
            .padding()
    }
}

// Styling for subtitle text.
struct SubtitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 35, weight: .regular, design: .rounded))
            .multilineTextAlignment(.center)
            .padding(0)
    }
}

// Styling for regular text.
struct RegularTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30, weight: .medium, design: .rounded))
            .multilineTextAlignment(.center)
            .padding()
    }
}

extension View {
    func buttonTextStyle() -> some View {
        modifier(ButtonTextStyle())
    }
    func largeIconButtonTextStyle() -> some View {
        modifier(LargeIconButtonTextStyle())
    }
    func titleTextStyle() -> some View {
        modifier(TitleTextStyle())
    }
    func subtitleTextStyle() -> some View {
        modifier(SubtitleTextStyle())
    }
    func regularTextStyle() -> some View {
        modifier(RegularTextStyle())
    }
}

extension Image {
    func imageStyle() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(20)
            .frame(height: 200)
    }
}
