//
//  HelpView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct HelpView: View {
    @State private var backgroundColor: Color = .blue.opacity(0.2)
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            NavigationStack {
                VStack(spacing: 50) {
                    Text("The assessment consists of eight parts. Some questions are easy, while others are more challenging and require a bit more concentration. If you need anything clarified, please approach a nearby caregiver.")
                        .titleTextStyle()
                    
                    Text("All The Best!")
                        .titleTextStyle()
                    
                    NavigationLink(destination: VisuospatialView()) {
                        Text("Proceed")
                            .buttonTextStyle()
                    }
                }
                .padding(150)
                .navigationTitle("Introduction")
            }
        }
    }
}
