//
//  NewCrewAlertView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/27.
//

import SwiftUI

struct NewCrewAlertView: View {
    @Binding var isPresented: Bool
    @State var crewNameText : String = ""
    @State var noticeText : String = ""
    @State var conditionIdx = 0
    @State var gradeIdx = 0
    @State var missionDateIdx = 0
    @State var missionCount = 0
    
     var missionDateArr : [String] = ["매일", "매주", "격일마다", "3일마다"]
    var conditionArr = ["모집중", "승인필요", "모집중단"]
    
    var minimumGrade = ["없음", "Newbie"]
    
    
    let title: String
    let message: String
    let primaryButtonTitle: String
    let primaryAction: () -> Void
    let withCancelButton: Bool

    var body: some View {
      VStack(spacing: 12) {
        Text(title)
          .foregroundColor(.black)
          .font(.title3)
          .bold()
          
          CustomTextField(
            text: $crewNameText,
            placeholder: "크루 이름",
            maximumCount: 16)
          Text("Notice")
            .foregroundColor(.black)
            .font(.title3)
            .bold()
          CustomTextField(
            text: $noticeText,
            placeholder: "텍스트를 입력하세요",
            maximumCount: 180)
          
          VStack{
              Text("가입조건")
                .foregroundColor(.black)
                .font(.title3)
                .bold()
              
              HStack{
                  Button(action: {  }) {
                      Image(systemName: "arrowshape.left.fill")
                  }
                  .buttonStyle(.reative)
                  
                  Text("\(conditionArr[conditionIdx])")
                      .font(.title3)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(minHeight: 60)
                  
                  Button(action: {  }) {
                      Image(systemName: "arrowshape.right.fill")
                  }
                  .buttonStyle(.reative)

              }
              
              Text("최소 등급")
                .foregroundColor(.black)
                .font(.title3)
                .bold()
              
              HStack{
                  Button(action: {  }) {
                      Image(systemName: "plus.app.fill")
                          .font(.system(size: 20))
                  }
                  .buttonStyle(.reative)
                  
                  Text("\(minimumGrade[gradeIdx])")
                      .font(.title3)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(minHeight: 60)
                  
                  Button(action: {  }) {
                      Image(systemName: "minus.square.fill")
                          .font(.system(size: 20))
                  }
                  .buttonStyle(.reative)

              }
              Text("미션 수행 조건")
                .foregroundColor(.black)
                .font(.title3)
                .bold()
              
              HStack{
                  Button(action: {  }) {
                      Image(systemName: "arrowshape.left.fill")
                  }
                  .buttonStyle(.reative)
                  
                  Text("\(missionDateArr[missionDateIdx])")
                      .font(.title3)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(minHeight: 60)
                  
                  Button(action: {  }) {
                      Image(systemName: "arrowshape.right.fill")
                  }
                  .buttonStyle(.reative)

              }
              
              HStack{
                  Button(action: {  }) {
                      Image(systemName: "plus.app.fill")
                          .font(.system(size: 20))
                  }
                  .buttonStyle(.reative)
                  
                  Text("\(missionCount)번 성공")
                      .font(.title3)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(minHeight: 60)
                  
                  Button(action: {  }) {
                      Image(systemName: "minus.square.fill")
                          .font(.system(size: 20))
                  }
                  .buttonStyle(.reative)

              }
              
          }
          
        
        
          
        Divider()

        HStack {
          if withCancelButton {
            Button(action: { isPresented = false }) {
              Text("취소")
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.cyan)
          }

          Button {
            primaryAction()
            isPresented = false
          } label: {
            Text(primaryButtonTitle)
              .bold()
              .padding(.vertical, 6)
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.borderedProminent)
          .tint(.cyan)
        }
      }
      .padding(16)
      .frame(width: 300)
      .background(
        RoundedRectangle(cornerRadius: 12)
          .stroke(.cyan.opacity(0.5))
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(.white)
          )
      )
    }
}

struct NewCrewAlertView_Previews: PreviewProvider {
    static var previews: some View {
        NewCrewAlertView( isPresented: .constant(true),
                          title: "New Crew",
                          message: "메시지메시지메시지~",
                          primaryButtonTitle: "확인!",
                          primaryAction: { },
                          withCancelButton: true)
    }
}
