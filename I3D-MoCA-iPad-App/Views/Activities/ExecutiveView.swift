//
//  ExecutiveView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct ExecutiveView: View {
    @StateObject private var manager = TaskManager(total: 1)
    @EnvironmentObject var activityManager: ActivityManager
    
    @State private var isErasing = false
    @State private var lineWidth: Double = 10.0
    @State private var lines = [Line]()

    var body: some View {
        ZStack {
            manager.backgroundColor
                .ignoresSafeArea()

            VStack {
                TaskHeaderView(
                    title: "Executive",
                    subtitle: "Draw a clock showing ten past eleven."
                )
                
                Spacer()

                if manager.currentIndex >= 1 {
                    CompletionView(
                        completionText: "🎉 You're done!",
                        buttonText: "Next Task",
                        onButtonTapped: {
                            activityManager.nextActivity(index: 1)
                        },
                        destination: MemoryView()
                    )
                } else {
                    drawingArea
                    controls
                }

                Spacer()
            }
        }
    }

    // MARK: - Drawing Area

    private var drawingArea: some View {
        DrawingCanvas(
            isErasing: $isErasing,
            lineWidth: $lineWidth,
            lines: $lines
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }

    // MARK: - Controls

    private var controls: some View {
        VStack {
            HStack(spacing: 20) {
                Button { isErasing = false } label: {
                    Image(systemName: "pencil").font(.title)
                }
                .foregroundColor(!isErasing ? .blue : .gray)

                Button { isErasing = true } label: {
                    Image(systemName: "eraser").font(.title)
                }
                .foregroundColor(isErasing ? .blue : .gray)

                Button { lines.removeAll() } label: {
                    Image(systemName: "trash").font(.title)
                }
                .foregroundColor(.red)

                Slider(value: $lineWidth, in: 1...20) {
                    Text("Width")
                }
                .frame(width: 200)

                Text(String(format: "%.0f", lineWidth))
                    .frame(width: 35, alignment: .leading)
            }
            .padding()

            HStack {
                Button {
                    manager.show3DPainting = true
                } label: {
                    Text("3D Painting").buttonTextStyle()
                }
                .padding(.trailing, 10)

                Button {
                    manager.nextTask()
                } label: {
                    Text("Submit").buttonTextStyle()
                }
            }
            .padding()
        }
    }
}

// MARK: - Line Model & Canvas

struct Line {
    var points: [CGPoint]
    var color: Color
    var lineWidth: Double
}

struct DrawingCanvas: View {
    @Binding var isErasing: Bool
    @Binding var lineWidth: Double
    @Binding var lines: [Line]
    @State private var currentPoints = [CGPoint]()

    private var effectiveLineWidth: Double {
        isErasing ? lineWidth * 4 : lineWidth
    }

    var body: some View {
        Canvas { context, size in
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                context.stroke(
                    path,
                    with: .color(line.color),
                    style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round)
                )
            }

            var currentPath = Path()
            currentPath.addLines(currentPoints)
            let currentColor = isErasing ? Color.white : Color.black
            context.stroke(
                currentPath,
                with: .color(currentColor),
                style: StrokeStyle(lineWidth: effectiveLineWidth, lineCap: .round, lineJoin: .round)
            )
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { currentPoints.append($0.location) }
                .onEnded { _ in
                    let color = isErasing ? Color.white : Color.black
                    lines.append(Line(points: currentPoints, color: color, lineWidth: effectiveLineWidth))
                    currentPoints = []
                }
        )
    }
}

// MARK: - Preview

struct ExecutiveView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExecutiveView()
                .environmentObject(ActivityManager())
        }
    }
}
