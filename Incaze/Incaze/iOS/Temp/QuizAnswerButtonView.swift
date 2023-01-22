//
//  QuizAnswerButton.swift
//  Tinowledge
//
//  Created by JeongMin Ko on 2023/01/05.
//

import SwiftUI
//퀴즈 상태 값
enum QuizState{
    case DEFAULT // 선택 안 한 상태.
    case SELECTED //정답 선택
}

struct QuizAnswerButtonView: View {
    
    var answerText = "플로리스트"
    var count = 882 //선택자 카운트
    var state : QuizState = .SELECTED
    
    var clickCompletion : (() -> ())?
    
    var body: some View {
        ZStack(alignment: .leading){
            
            
            VStack(alignment: .leading){
                //정답 텍스트
                HStack{
                    Text(answerText).font(.system(size: 20,weight: .medium))
                    Spacer()
                }
                .padding(.leading,20)
                .padding(.top, 20)
                
                
                if state == .SELECTED{
                    //선택 카운트
                    Text("\(count)").font(.system(size: 10,weight: .light))
                        .padding(.leading,20)
                        .padding(.bottom, 20)
                    
                }
                
            }
            .background(Color(red: 245 / 255, green: 244 / 255, blue: 255 / 255))
            .cornerRadius(30, corners: .allCorners)
            .onTapGesture {
                print("버튼 클릭")
                submitAns()
                
                
                
            }
            
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .frame(width: 100,height: 80)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.red.opacity(0.3), .blue.opacity(0.3)]),
                        startPoint: .leading,
                        endPoint: .trailing)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                )
                
            
                .foregroundColor(.clear)
            
        }
    }
    /*
     정답 제출
     */
    func submitAns(){
        clickCompletion?()
    }
}

struct QuizAnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        QuizAnswerButtonView()
    }
}
