//
//  BoardListView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import SwiftUI

struct BoardListView: View {
    @ObservedObject var viewModel : BoardListViewModel = BoardListViewModel()
    @State private var items: [Item] = []
    @State private var newItem = Item()

        var body: some View {
            VStack {
                List {
                    ForEach(viewModel.rooms, id: \.id) { item in
//                        Card {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.contents)
                                    .font(.subheadline)
                                Text("\(item.memberCount)/\(item.limitMember)")
                            }
//                        }
                    }
                }.onAppear(perform: {
                    viewModel.observeItemList()
                })

                Form {
                    TextField("Item name", text: $newItem.name)
                    TextField("Item price", text: $newItem.price)
                    TextField("Item description", text: $newItem.description)
                    Button("Sell") {
                        var userid = UserManager.shared.id
                        var newRoom = Room(id: userid ,
                                           title: newItem.name,
                                           contents: newItem.description,
                                           userId: userid,
                                           limitMember: 2,
                                           memberCount: 1,
                                           partyIds: [Int(userid) ?? 0 ])
                        viewModel.createRoom(room: newRoom)
                    }
                }
                .padding()
            }
        }

        struct Item {
            var id = UUID()
            var name = ""
            var price = ""
            var description = ""
        }
}

struct BoardListView_Previews: PreviewProvider {
    static var previews: some View {
        BoardListView(viewModel: BoardListViewModel())
    }
}
