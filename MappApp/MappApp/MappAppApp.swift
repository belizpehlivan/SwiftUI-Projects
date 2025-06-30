//
//  MappAppApp.swift
//  MappApp
//
//  Created by Beliz on 6/13/25.
//

import SwiftUI

@main
struct MappAppApp: App {
    
    @StateObject private var vm: LocationsViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
        }
        .environmentObject(vm)
    }
}
