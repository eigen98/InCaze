//
//  ChallengeStartView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/03.
//

import SwiftUI

struct ChallengeStartView: View {
    var width = UserManager.shared.deviceWidth
    @State private var distance: Double = 0.0
    @State private var pace: Double = 0.0
    @State private var time: Double = 0.0
    @State private var limitTime : Int = 300
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var body: some View {
        VStack(spacing: 20) {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    TimesUpView()
                    Text("\(limitTime)초")
                        .font(.system(size: 50,weight: .bold))
                        .foregroundColor(Color(red: 31/255, green: 187/255, blue: 216/255))
                }
               
                       
                   
                   RunProgressBarView()
               }
               
               HStack {
                   Image(systemName: "figure.run")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 40, height: 40)
                       
                   VStack(alignment: .leading) {
                       Text("Distance")
                           .font(.headline)
                       Text("\(self.distance, specifier: "%.2f") miles")
                           .font(.title)
                   }
                   Spacer()
                   VStack(alignment: .leading) {
                       Text("Pace")
                           .font(.headline)
                       Text("\(self.pace, specifier: "%.2f") min/mile")
                           .font(.title)
                   }
                   Spacer()
                   VStack(alignment: .leading) {
                       Text("Time")
                           .font(.headline)
                       Text("\(Int(self.time)) sec")
                           .font(.title)
                   }
               }
               .padding()
               .background(Color(UIColor.systemGray6))
               .cornerRadius(10)
               
               Button(action: {
                   // End the run here
               }) {
                   Text("End Run")
                       .font(.title)
                       .bold()
                       .padding()
                       .background(Color.red)
                       .foregroundColor(.white)
                       .cornerRadius(40)
               }
               
               
           }
           .padding()
           .onReceive(timer) {_ in
               self.time += 1.0
               if self.limitTime > 0{
                   self.limitTime -= 1
                   
               }else{
                   showTimeOutRunModal()
               }
               
               // Update distance and pace based on elapsed time
           }
           .background(.black)
       }
    
    
    func showTimeOutRunModal(){
        
        self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
            TimeOutModalView()
        }
    }
    
    func showEndRunModal(){
        
        self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
            TimeOutModalView()
        }
    }
    
}

struct ChallengeStartView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeStartView()
    }
}
