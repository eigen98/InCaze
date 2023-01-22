//
//  TestView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/29.
//

import SwiftUI
import Combine
struct TestView: View {
    
    @State var centerPosition = CGPoint(x: 100, y: 100)
    @State var x : CGFloat = 100
    @State var y : CGFloat = 100
    var body: some View {
        
        VStack{
            
            MiniMapView()
//            withAnimation{
//                RunTrackingView(now: $centerPosition)
//                    .frame(width: 200,height: 200)
//                    .position(centerPosition)
//
//                    .animation(.easeInOut(duration: 10), value: centerPosition)
//            }
        }
       
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
struct MiniMapView: View {
  @State private var vehiclePositions: [CGPoint] = [CGPoint]()
  
  var body: some View {
    ZStack {
      // Draw the track layout
      Rectangle()
        .fill(Color.gray)
        .frame(width: 300, height: 200)

      // Draw the vehicles on the mini map
      ForEach(0..<vehiclePositions.count) { index in
        Circle()
          .fill(Color.red)
          .frame(width: 10, height: 10)
          .offset(x: self.vehiclePositions[index].x - 5, y: self.vehiclePositions[index].y - 5)
      }
    }
    .onReceive(Publishers.Sequence(sequence: vehiclePositions)) { newPositions in
      withAnimation {
        self.vehiclePositions = [
            CGPoint(x: 50, y: 50),
            CGPoint(x: 250, y: 150),
            CGPoint(x: 150, y: 100)
          ]
      }
    }

  }
}
