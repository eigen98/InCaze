//
//  ChallengingView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/03.
//

import SwiftUI

struct ChallengingView: View {
    @State private var distance: Double = 0.0
     @State private var pace: Double = 0.0
     @State private var time: Double = 0.0
     @State private var targetDistance: Double = 5.0
     @State private var targetTime: Double = 600.0
     private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color(UIColor(red:0.05, green:0.33, blue:0.66, alpha:1.0))
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Running Challenge")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Target Distance")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(self.targetDistance, specifier: "%.2f") miles")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Target Time")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(Int(self.targetTime / 60)) min \(Int(self.targetTime.truncatingRemainder(dividingBy: 60))) sec")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color(UIColor(red:0.05, green:0.33, blue:0.66, alpha:0.6)))
                .cornerRadius(10)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Current Distance")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(self.distance, specifier: "%.2f") miles")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Current Pace")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(self.pace, specifier: "%.2f") min/mile")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Time Elapsed")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(Int(self.time)) sec")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                //                        .background(Color(UIColor(red:0
            }
        }
    }
}

struct ChallengingView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengingView()
    }
}
