//
//  CrewListView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import SwiftUI

struct CrewListView: View {
    @ObservedObject var viewModel : CrewListViewModel// = CrewListViewModel(service: CrewServiceServiceImpl(crewRepo: CrewRepositoryImpl()))
    @State private var showsNewCrewModal = false

    var body: some View {
    
        NavigationView{
            ZStack {
                ScrollView{
                    
                    LazyVStack.init(spacing: 0, pinnedViews: [.sectionHeaders]){
                        Section{
                            HStack{
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 16)
                                                   .fill(Color.init(red: 174/255, green: 147/255, blue: 186/255))
                                                   .frame( height: 46)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 16)
                                                           .stroke(lineWidth: 3)
                                                           .foregroundColor(.black)
                                                   )
                                    
                                    
                                    TextField("", text: $viewModel.searchText,
                                              prompt: Text("크루 이름 입력")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 20, weight: .medium))
                                        
                                    )
                                      .padding()
//                                      .background(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.black)
//
//
//                                      )
                                }
                                //.background(Color.init(red: 40/255, green: 57/255, blue: 87/255))
                                
                                .padding(.leading, 20)
                                
                                Button {
                                  
                                } label: {
                                  Image(systemName: "magnifyingglass") //편집
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.vertical, 4)
                                    
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(Color.init(red: 210/255, green: 120/255, blue: 145/255))
                                .frame(width: 80, height: 50)
                                
                            }
                            .padding(.vertical, 16)
                        }
                        
                        Section(){
                            ForEach(viewModel.crewList){crew in
                                NavigationLink(destination: {
                                    CrewDetailView(viewModel: CrewDetailViewModel(service: CrewServiceServiceImpl(crewRepo: CrewRepositoryImpl()), crewId: crew.id))
                                }, label: {
                                    CrewListCellView(crew: crew)
                                        .padding(.vertical,4)
                                })
                               
                                    
                            }
                        }
                    }
                    
                    
                    
                  
                  
                }
                //업데이트
                .refreshable {
                    viewModel.getCrewList()
                }
                .onAppear{
                    viewModel.getCrewList()
                }
                .background(Color.init(red: 30/255, green: 26/255, blue: 62/255))
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            showsNewCrewModal.toggle()
                        }, label: {
                            Image(systemName: "plus.app.fill")
                                .font(.system(size: 60))
                        }).padding(.horizontal, 32)
                    }.padding(.vertical, 32)
                }
               
            }
            .showNewCrewModal(isPresented: $showsNewCrewModal,
                         title: "타이틀", message: "ㄴㅇㄹ",
                         primaryButtonTitle: "생성",
                              primaryAction: {name, type ,count , grade in
                
                viewModel.createNewCrew(name: name, type: type, maxCount: count, minimumGrade: grade)
            }, withCancelButton: true)
        }
        
    }
}

struct CrewListView_Previews: PreviewProvider {
    static var previews: some View {
        CrewListView(viewModel: CrewListViewModel(service: CrewServiceServiceImpl(crewRepo: CrewRepositoryImpl())))
    }
}
