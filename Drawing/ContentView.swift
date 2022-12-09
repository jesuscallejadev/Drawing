//
//  ContentView.swift
//  Drawing
//
//  Created by Jesus Calleja on 29/11/22.
//

import SwiftUI

struct Arrow: Shape {
    var width: CGFloat
    var offset: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: width/2, y: offset - 40))
            path.move(to: CGPoint(x: width/2, y: offset - 40))
            path.addLine(to: CGPoint(x: width, y: 0))
        }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {

    @State private var arrowWidth: CGFloat = 10.0
    @State private var colorCycle: CGFloat = 0.0


    var body: some View {
            VStack {
                Arrow(width: 100, offset: -20)
                    .stroke(.red, style: StrokeStyle(lineWidth: arrowWidth, lineCap: .round, lineJoin: .round))
                    .frame(width: 80)
                    .foregroundColor(.green)
                    .contentShape(Rectangle())
                    .padding(.top, 100)
                    .padding()

                Slider(value: $arrowWidth, in: 0...10)
                    .padding(.top, 10)
                    .frame(width: 300)

                ColorCyclingRectangle(amount: colorCycle)
                    .frame(width: 300, height: 300)

                Slider(value: $colorCycle)
                    .padding(.top, 10)
                    .frame(width: 300)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accentColor(.white)
            .background(.black)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
