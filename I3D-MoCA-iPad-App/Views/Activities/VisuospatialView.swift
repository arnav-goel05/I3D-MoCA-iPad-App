//
//  VisuospatialView.swift
//  I3D-MoCA-iPad-App
//
//  Created by Interactive 3D Design on 25/6/25.
//

import SwiftUI

struct Node: Identifiable, Equatable {
    let id: String
    let position: CGPoint
}

struct ConnectingLine: Identifiable {
    let id = UUID()
    var start: CGPoint
    var end: CGPoint
}

struct Arrow: Shape {
    var start: CGPoint
    var end: CGPoint
    var headLength: CGFloat = 20
    var headAngle: CGFloat = .pi / 8

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let angle = atan2(end.y - start.y, end.x - start.x)
        let nodeRadius: CGFloat = 45
        
        let shortenedStart = CGPoint(
            x: start.x + nodeRadius * cos(angle),
            y: start.y + nodeRadius * sin(angle)
        )
        let shortenedEnd = CGPoint(
            x: end.x - nodeRadius * cos(angle),
            y: end.y - nodeRadius * sin(angle)
        )

        path.move(to: shortenedStart)
        path.addLine(to: shortenedEnd)

        let arrowP1 = CGPoint(
            x: shortenedEnd.x - headLength * cos(angle - headAngle),
            y: shortenedEnd.y - headLength * sin(angle - headAngle)
        )
        let arrowP2 = CGPoint(
            x: shortenedEnd.x - headLength * cos(angle + headAngle),
            y: shortenedEnd.y - headLength * sin(angle + headAngle)
        )

        path.move(to: arrowP1)
        path.addLine(to: shortenedEnd)
        path.addLine(to: arrowP2)

        return path
    }
}

struct VisuospatialView: View {
    @EnvironmentObject private var activityManager: ActivityManager

    private let nodes: [Node] = [
        Node(id: "1", position: CGPoint(x: 450, y: 350)),
        Node(id: "A", position: CGPoint(x: 650, y: 150)),
        Node(id: "2", position: CGPoint(x: 800, y: 200)),
        Node(id: "B", position: CGPoint(x: 650, y: 300)),
        Node(id: "3", position: CGPoint(x: 800, y: 550)),
        Node(id: "C", position: CGPoint(x: 400, y: 600)),
        Node(id: "4", position: CGPoint(x: 600, y: 500)),
        Node(id: "D", position: CGPoint(x: 300, y: 500)),
        Node(id: "5", position: CGPoint(x: 250, y: 250)),
        Node(id: "E", position: CGPoint(x: 450, y: 100))
    ]

    @State private var lines: [ConnectingLine] = []
    @State private var currentLine: ConnectingLine?
    @State private var selectedNodes: [Node] = []
    
    var body: some View {
        VStack {
          header
          drawingCanvas
            .gesture(drawingGesture)
          controls
        }
      }

      // MARK: – Subviews

      private var header: some View {
        TaskHeaderView(
          title: "Visuospatial",
          subtitle: "Connect the nodes in ascending order, alternating between numbers and letters (1-A-2-B…)"
        )
      }

      private var drawingCanvas: some View {
        ZStack {
          initialHints
          drawnLines
          liveLine
          nodeViews
        }
      }

      private var controls: some View {
        HStack(spacing: 20) {
          Button { reset() } label: {
            HStack { Spacer(); Image(systemName: "arrow.counterclockwise"); Text("Reset"); Spacer() }
          }
          .buttonTextStyle()

          NavigationLink(destination: ExecutiveView()) {
            Text("Next Task").buttonTextStyle()
          }
        }
        .padding()
      }

      // MARK: – Drawing Layers

      private var initialHints: some View {
        Group {
          if lines.isEmpty,
             let first = nodes.first(where: { $0.id == "1" }),
             let second = nodes.first(where: { $0.id == "A" }),
             let third = nodes.first(where: { $0.id == "2" })
          {
            Arrow(start: first.position, end: second.position)
              .stroke(Color.gray, style: .init(lineWidth: 5, lineCap: .round, dash: [15,15]))
            Arrow(start: second.position, end: third.position)
              .stroke(Color.gray, style: .init(lineWidth: 5, lineCap: .round, dash: [15,15]))
          }
        }
      }

      private var drawnLines: some View {
        ForEach(lines) { line in
          Arrow(start: line.start, end: line.end)
            .stroke(Color.primary, lineWidth: 5)
        }
      }

      private var liveLine: some View {
        Group {
          if let current = currentLine {
            Path { path in
              let angle = atan2(current.end.y - current.start.y,
                                current.end.x - current.start.x)
              let r: CGFloat = 45
              let start = CGPoint(
                x: current.start.x + r * cos(angle),
                y: current.start.y + r * sin(angle)
              )
              path.move(to: start)
              path.addLine(to: current.end)
            }
            .stroke(Color.secondary, lineWidth: 3)
          }
        }
      }

      private var nodeViews: some View {
        ForEach(nodes) { node in
          ZStack {
            Circle()
              .fill(nodeColor(node))
              .frame(width: 90, height: 90)
            Text(node.id)
              .font(.system(size: 50, weight: .bold, design: .rounded))
          }
          .position(node.position)
          .onTapGesture { removeLine(startingAt: node) }
        }
      }

      // MARK: – Gesture

      private var drawingGesture: _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture(minimumDistance: 0)
          .onChanged { handleDragChanged($0) }
          .onEnded { handleDragEnded($0) }
      }

      // MARK: – Helpers

      private func handleDragChanged(_ value: DragGesture.Value) {
        if currentLine == nil {
          if let start = node(at: value.startLocation),
             !lines.contains(where: { $0.start == start.position })
          {
            currentLine = ConnectingLine(start: start.position, end: value.location)
          }
        } else {
          currentLine?.end = value.location
        }
      }

      private func handleDragEnded(_ value: DragGesture.Value) {
        defer { currentLine = nil }
        guard var line = currentLine,
              let start = node(at: line.start),
              let end = node(at: value.location),
              start != end,
              !lines.contains(where: { $0.start == start.position }),
              !lines.contains(where: { $0.end == end.position })
        else { return }

        line.end = end.position
        lines.append(line)
        selectedNodes.append(contentsOf: [start, end].filter { !selectedNodes.contains($0) })
      }

      private func reset() {
        lines.removeAll()
        selectedNodes.removeAll()
      }

    private func removeLine(startingAt tappedNode: Node) {
        if let idx = lines.firstIndex(where: { $0.start == tappedNode.position }) {
            let removed = lines.remove(at: idx)
            if let other = self.node(at: removed.end) {
                selectedNodes.removeAll { $0 == tappedNode || $0 == other }
            }
        }
    }

      private func node(at point: CGPoint) -> Node? {
        nodes.first { hypot(point.x - $0.position.x, point.y - $0.position.y) <= 45 }
      }

    private func nodeColor(_ node: Node) -> Color {
        if selectedNodes.contains(node) { return .green }
        if let current = currentLine, current.start == node.position { return .orange }
        return .yellow
    }
}
