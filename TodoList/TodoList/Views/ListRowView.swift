//
//  ListRowView.swift
//  TodoList
//
//  Created by Beliz on 6/9/25.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isDone ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}
#Preview {
    var item1 = ItemModel(title: "Title1", isDone: true)
    var item2 = ItemModel(title: "Title2", isDone: false)
    
    Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
    }
}
