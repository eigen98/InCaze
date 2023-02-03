//
//  RunProgressBarView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/03.
//

import SwiftUI
import Combine
struct RunProgressBarView: View {
    
    var width = UserManager.shared.deviceWidth
    var step = (UserManager.shared.deviceWidth - 40) / 5
    
    @State private var progress: CGFloat = 0.0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        VStack {
            
            LottieView(jsonName: "BasicRunner")
                .frame(width: 160, height: 160)
                .offset(x: (progress - width/2),y: 46)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: width - 40, height: 10)
                    .opacity(0.3)
                Rectangle()
                    .frame(width: min(self.progress, width - 40), height: 10)
                    .foregroundColor(Color.blue)
                    .animation(.linear)
                
                HStack(spacing: step) {
                    Circle()
                        .fill(self.progress >= 0 ? Color.green : Color.gray)
                        .frame(width: 20,height: 20)
                    Circle()
                        .fill(self.progress >= step + 20 ? Color.green : Color.gray)
                        .frame(width: 20,height: 20)
                    
                    Circle()
                        .fill(self.progress >= width / 2 ? Color.green : Color.gray)
                        .frame(width: 20,height: 20)
                    
                    Circle()
                        .fill(self.progress >= step * 4 ? Color.green : Color.gray)
                        .frame(width: 20,height: 20)
                    
                    Circle()
                        .fill(self.progress >= step * 5 ? Color.green : Color.gray)
                        .frame(width: 20,height: 20)
                    
                    
                    
                }
                .frame(width: width - 40)
            }
            
        }
        .onReceive(timer) { _ in
            if self.progress < width - 40 {
                self.progress += (UserManager.shared.deviceWidth - 40) / (100)
                    }
                }
    }
}

struct RunProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        RunProgressBarView()
    }
}
