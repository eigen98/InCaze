//
//  CrewDetailView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/27.
//

import SwiftUI

struct CrewDetailView: View {
    
    @StateObject var viewModel : CrewDetailViewModel// = CrewDetailViewModel(service: CrewServiceServiceImpl(crewRepo: CrewRepositoryImpl()))
    @State private var crewInfo : CrewModel? = nil
    @State var buttonText = "수정"
    var body: some View {
        ScrollView{
            
            
            LazyVStack.init(spacing: 0, pinnedViews: [.sectionHeaders]){
                
                
                
                let headerSection = Section{
                    CrewInfoHeaderView(crewInfo: $crewInfo,
                                       buttonClosure: {viewModel.buttonClosure() },
                                       buttonText: $buttonText
                    )
                        .padding(.vertical, 8)
                }
                
                headerSection
                    
                
                
                Section(){
                    ForEach(crewInfo?.users ?? []){ userInfo in
                        CrewPlayerCellView(user: userInfo)
                            .padding(.vertical,4)
                    }
                }
                
                
            }
            

        }
        .background(Color.init(red: 46/255, green: 60/255, blue: 87/255))
        .onAppear{
            viewModel.fetchCrewDetail()
        }
        .onReceive(viewModel.crewPublisher){output in
            self.crewInfo = output
            print("receive crew \(output)")
            
            var me = UserManager.getMe()
            //내가 만든 크루인경우
            if me.id == output.leaderId {
              buttonText = "삭제"
            }
            //가입한 크루가 없는 경우.
            else if me.crewId?.count == 0 || me.crewId == nil{
                //승인이 필요한 경우
                buttonText = "요청"
                //바로 가입 가능한 경우
                buttonText = "가입"
            }
            //이미 크루에 가입한 경우 X
            
        }// 삭제 후 닫힘
        .onReceive(viewModel.isDeleted){output in
            NavigationUtil.popToRootView()
        }
        
        
    }
    
    
}

struct CrewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CrewDetailView(viewModel: CrewDetailViewModel(service: CrewServiceServiceImpl(crewRepo: CrewRepositoryImpl()), crewId: "ko_su"))
    }
}
