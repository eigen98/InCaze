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
    
    var body: some View {
        ScrollView{
            
            
            LazyVStack.init(spacing: 0, pinnedViews: [.sectionHeaders]){
                
                
                
                let headerSection = Section{
                    CrewInfoHeaderView(crewInfo: $crewInfo)
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
        }.onReceive(viewModel.crewPublisher){output in
            self.crewInfo = output
            print("receive crew \(output)")
        }
    }
    
    
}

struct CrewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CrewDetailView(viewModel: CrewDetailViewModel(service: CrewServiceServiceImpl(crewRepo: CrewRepositoryImpl()), crewId: "ko_su"))
    }
}
