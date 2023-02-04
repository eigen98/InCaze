//
//  ChallengeStageView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/04.
//

import SwiftUI

struct ChallengeStageView: View {
    var body: some View {
        ZStack{
            Color.init(red: 30/255, green: 26/255, blue: 62/255)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                LazyVStack.init(spacing: 16, pinnedViews: [.sectionHeaders]) {
                    Section{
                        ForEach(0..<10) { index in
                            HStack {
                                VStack{
                                    NavigationLink(destination: {
                                        ChallengeStartView(targetDistance: 500.0, targetTime: 100, viewModel: ChallengeStartViewModel())
                                        //ChallengeStartView(viewModel: ChallengeStartViewModel())
                                    }, label: {
                                        Text("\(index) - 0")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 22, weight: .bold))
                                    })
                                        
                                }.modifier(ClearFrameModifier())
                                
                                VStack{
                                    NavigationLink(destination: {
                                       // ChallengeStartView(viewModel: ChallengeStartViewModel())
                                    }, label: {
                                        Text("\(index) - 1")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 22, weight: .bold))
                                    })
                                }.modifier(PossibleFrameModifier())
                                
                                VStack{
                                    NavigationLink(destination: {
                                       // ChallengeStartView(viewModel: ChallengeStartViewModel())
                                    }, label: {
                                        Text("\(index) - 2")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 22, weight: .bold))
                                    })
                                }.modifier(UnableFrameModifier())
                                
                                VStack{
                                    NavigationLink(destination: {
                                       // ChallengeStartView(viewModel: ChallengeStartViewModel())
                                    }, label: {
                                        Text("\(index) - 3")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 22, weight: .bold))
                                    })
                                }.modifier(UnableFrameModifier())
                                
                            }
                        }
                    }
                }
                .padding(.top, 16)
            }
           
        }
        .navigationTitle("Stage")
        
    }
}

struct ChallengeStageView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeStageView()
    }
}
