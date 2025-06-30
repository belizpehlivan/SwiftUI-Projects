//
//  TodoListApp.swift
//  TodoList
//
//  Created by Beliz on 6/3/25.
//

import SwiftUI
 
@main
struct TodoListApp: App {
    
    // Instantiate the observable object ListViewModel
    @StateObject private var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel) // every subview can access this object
        }
    }
}
