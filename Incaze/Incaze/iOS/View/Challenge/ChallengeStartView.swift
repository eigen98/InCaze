//
//  ChallengeStartView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/03.
//

import SwiftUI
//챌린지 진행 뷰
struct ChallengeStartView: View {
    var width = UserManager.shared.deviceWidth
    var targetDistance : Double
    var targetTime : Int
    var stage : String = "0-1"
    @State private var distance: Double = 0.0
    @State private var pace: Double = 0.0
    @State private var time: Double = 0.0
    @State private var limitTime : Int = 300
    
    @ObservedObject var viewModel : ChallengeStartViewModel
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    //For pop to RootView
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
               
                
                //콘솔 용도
                VStack{
                    Text("distacne \(viewModel.distance)")
                        .foregroundColor(Color(red: 31/255, green: 187/255, blue: 216/255))
                    Text("pace \(viewModel.pace)")
                        .foregroundColor(Color.red)
                    Text("caloriesBurned \(viewModel.caloriesBurned)")
                        .foregroundColor(Color.green)
                    Text("duration \(viewModel.duration)")
                        .foregroundColor(Color.yellow)
                }.font(.system(size: 26,weight: .bold))
                    
                
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
           .onAppear{
               //측정 시작
               viewModel.startRace()
           }//완주 성공
           .onReceive(viewModel.distanceSubject){distance in
               if distance >= 0.3{
                   showEndRunModal()
               }
               
           }
           .onReceive(timer) {_ in
               self.time += 1.0
               if self.limitTime > 0{
                   self.limitTime -= 1
                   
               }else{
                   //완주 실패
                   showTimeOutRunModal()
               }
               
           }
          
           .background(.black)
       }
    
    //완주 실패
    func showTimeOutRunModal(){
        //서버 반영
        viewModel.endRace(stage: "\(stage)", isSuccess: false)
        
        self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
            TimeOutModalView()
                .onDisappear{
                    NavigationUtil.popToRootView()
                }
        }
    }
    //경기 종료
    func showEndRunModal(){
        //서버 반영
        viewModel.endRace(stage: "\(stage)", isSuccess: true)
        
        self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
            ClearModalView()
                .onDisappear{
                    NavigationUtil.popToRootView()
                }
        }
    }
    
}

struct ChallengeStartView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeStartView(targetDistance: 100.0,
                           targetTime: 0,
                           viewModel: ChallengeStartViewModel())
    }
}
