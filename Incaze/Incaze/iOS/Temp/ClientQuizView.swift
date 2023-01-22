//
//  ClientQuizView.swift
//  Tinowledge
//
//  Created by JeongMin Ko on 2023/01/05.
//

import SwiftUI

struct ClientQuizView: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        //퀴즈 Content
        
        
            VStack(alignment: .leading){
                
                HStack(alignment: .center){
                    Spacer()
                    QuizProgressView()
                    Spacer()
                }.padding(.top, 40)
               
                
                
                HStack{
                    Text("다음 중 \n약을 만드는 데 \n중요한 역할을 하는 사람은?")
                        .font(.system(size: 20,weight: .medium))
                        .padding(20)
                    
                    TimerView()
                        .frame(width: 70, height: 70)
                        
                }
                .padding(.vertical, 20)
                
                Spacer()
                List(content: {
                    QuizAnswerButtonView(clickCompletion: {submitAnswer()})
                    QuizAnswerButtonView(clickCompletion: {submitAnswer()})
                    QuizAnswerButtonView(clickCompletion: {submitAnswer()})
                    QuizAnswerButtonView(clickCompletion: {submitAnswer()})
                })
                .padding(.horizontal, 20)
                
                HStack{
                    
                    Button(action: {
                        
                    }, label: {
                        Text("이전")
                    })
                    
                    .frame(width: 80, height: 30, alignment: .center)
                    .font(.system(size: 20 ,weight: .bold))
                    .foregroundColor(.white)
                    .background(.yellow)
                    .cornerRadius(12, corners: .allCorners)
                    .padding(.leading, 20)
                    
                    
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("다음")
                    })
                    
                    .frame(width: 80, height: 30, alignment: .center)
                    .font(.system(size: 20 ,weight: .bold))
                    .foregroundColor(.white)
                    .background(.yellow)
                    .cornerRadius(12, corners: .allCorners)
                    .padding(.trailing, 20)
                }
            }
            .onAppear(perform: {
                showStartQuizModal()
            })
        
        
        //퀴즈 정답 제출
        
    }
        
    
    func submitAnswer(){
        
    }
    
    func tapNextQuizBtn(){
        
    }
    
    func tapPrevQuizBtn(){
        
    }
    func showStartQuizModal(){
        self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
            StartQuizModalView()
            
        }
    }
}

struct ClientQuizView_Previews: PreviewProvider {
    static var previews: some View {
        ClientQuizView()
    }
}
