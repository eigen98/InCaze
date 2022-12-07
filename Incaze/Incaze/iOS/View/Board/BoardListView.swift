//
//  BoardListView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import SwiftUI

struct BoardListView: View {
    @State private var items: [Item] = []
        @State private var newItem = Item()

        var body: some View {
            VStack {
                List {
                    ForEach(items, id: \.id) { item in
//                        Card {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.price)
                                    .font(.subheadline)
                                Text(item.description)
//                            }
                        }
                    }
                }

                Form {
                    TextField("Item name", text: $newItem.name)
                    TextField("Item price", text: $newItem.price)
                    TextField("Item description", text: $newItem.description)
                    Button("Sell") {
                        self.items.append(self.newItem)
                        self.newItem = Item()
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
        BoardListView()
    }
}
