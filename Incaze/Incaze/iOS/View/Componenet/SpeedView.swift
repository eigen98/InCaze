//
//  GaugeView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/19.
//

import Foundation
//
//  SpeedView.swift
//

import SwiftUI

struct SpeedView: View {
    @Binding var value : Double
    var body: some View {
        VStack {
            GaugeView(coveredRadius: 225, maxValue: 100, steperSplit: 10, value: $value)
//            Slider(value: $value, in: 0...100, step: 1)
//                .padding(.horizontal, 20)
            HStack {
                Spacer()
//                Button(action: {
//                    self.value = 0
//                }) {
//                    Text("Zero")
//                }.foregroundColor(.blue)
                Spacer()
//                Button(action: {
//                    self.value = 100
//                }) {
//                    Text("Max")
//                }.foregroundColor(.blue)
                Spacer()
            }
        }
    }
}

struct Needle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height/2))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}

struct GaugeView: View {
    func colorMix(percent: Int) -> Color {
        let p = Double(percent)
        let tempG = (100.0-p)/100
        let g: Double = tempG < 0 ? 0 : tempG
        let tempR = 1+(p-100.0)/100.0
        let r: Double = tempR < 0 ? 0 : tempR
        return Color.init(red: r, green: g, blue: 0)
    }
    
    //속도계 눈금
    func tick(at tick: Int, totalTicks: Int) -> some View {
        let percent = (tick * 100) / totalTicks
        let startAngle = coveredRadius/2 * -1
        let stepper = coveredRadius/Double(totalTicks)
        let rotation = Angle.degrees(startAngle + stepper * Double(tick))
        return VStack {
                   Rectangle()
                    .fill(colorMix(percent: percent))
                       .frame(width: tick % 2 == 0 ? 3 : 2,
                              height: tick % 2 == 0 ? 10 : 5) //alternet small big dash
                   Spacer()
           }.rotationEffect(rotation)
    }
    //속도계 숫자
    func tickText(at tick: Int, text: String) -> some View {
        let percent = (tick * 100) / tickCount
        let startAngle = coveredRadius/2 * -1 + 90
        let stepper = coveredRadius/Double(tickCount)
        let rotation = startAngle + stepper * Double(tick)
        return Text(text)
            .foregroundColor(colorMix(percent: percent))
            .rotationEffect(.init(degrees: -1 * rotation),
                            anchor: .center)
            .offset(x: -50, y: 0) //숫자 원 크기 조절
            .rotationEffect(Angle.degrees(rotation))
    }
    
    let coveredRadius: Double // 0 - 360°
    let maxValue: Int
    let steperSplit: Int
    
    private var tickCount: Int {
        return maxValue/steperSplit
    }
    
    @Binding var value: Double
    var body: some View {
        ZStack {
            
//            //속도 텍스트
//            Text("\(value, specifier: "%0.0f")")
//                .font(.system(size: 40, weight: Font.Weight.bold))
//                .foregroundColor(Color.orange)
//                .offset(x: 0, y: 40)
            
            //속도계 눈금
            ForEach(0..<tickCount*2 + 1) { tick in
                self.tick(at: tick, totalTicks: self.tickCount*2)
            }
            
            //속도계 숫자
//            ForEach(0..<tickCount+1) { tick in
//                self.tickText(at: tick, text: "\(self.steperSplit*tick)")
//            }
            
            Needle()
                .fill(Color.red)
                .frame(width: 50, height: 6)
                .offset(x: -30, y: 0)
                .rotationEffect(.init(degrees: getAngle(value: value)), anchor: .center)
                .animation(.linear)
            
            //눈금 원
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(.red)
            
        }.frame(width: 80, height: 80, alignment: .center)
    }
    
    func getAngle(value: Double) -> Double {
        return (value/Double(maxValue))*coveredRadius - coveredRadius/2 + 90
    }
}

struct SpeedView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedView(value: .constant(0.0))
    }
}
