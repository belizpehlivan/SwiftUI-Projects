//
//  ListViewModel.swift
//  TodoList
//
//  Created by Beliz on 6/9/25.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            // if elements of items change, saveItem is called
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
//        let newItems = [
//            ItemModel(title: "Buy milk", isDone: false),
//            ItemModel(title: "Learn SwiftUI", isDone: true),
//            ItemModel(title: "Go for a walk", isDone: false),
//        ]
//        items.append(contentsOf: newItems)

        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let decodedItems = try? JSONDecoder().decode([ItemModel].self, from: data) // Decode to ItemModel's type -> [ItemModel].self.
                                                                                        // Not an actual array
        else { return }
        self.items = decodedItems
    }
    
    func deleteItem(at: IndexSet) {
        items.remove(atOffsets: at)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isDone: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
//        if let index = items.firstIndex(where: { existingItem in
//            return existingItem.id == item.id
//        }) {
//            
//        }
        
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
        
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
       
    }
}
