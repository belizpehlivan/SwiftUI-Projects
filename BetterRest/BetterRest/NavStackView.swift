//
//  NavStackView.swift
//  BetterRest
//
//  Created by Beliz on 8/24/25.
//

import SwiftUI

struct NavStackView: View {
    // Navigation state is held in a path array
    @State private var path: [Int] = []

    var body: some View {
        // Attach the path to NavigationStack
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                
                // Declarative navigation: pushes 1 onto the stack
                NavigationLink("Go to 1", value: 1)

                // Programmatic push: manually append 2
                Button("Push 2") {
                    // You change the state. Swiftui pushes the destination to screen
                    path.append(2)
                }

                // Programmatic pop: clear stack → back to root
                Button("Pop to root") {
                    path.removeAll()
                }
            }
            .navigationTitle("Home")
            
            // This block runs for every Int values in the path
            .navigationDestination(for: Int.self) { number in
                DetailView(number: number, path: $path)
            }
        }
    }
}

struct DetailView: View {
    let number: Int
    @Binding var path: [Int]  // binding to modify stack

    var body: some View {
        VStack(spacing: 20) {
            Text("Detail of \(number)")

            // Programmatic push: go deeper with number * 10
            Button("Go deeper (\(number * 10))") {
                // Path is changed, swiftui runs again navigationDestination(for: Int.self) and opens up a new DetailView
                path.append(number * 10)
            }

            // Programmatic pop: remove last element in stack
            Button("Back") {
                _ = path.popLast()
            }
        }
        .navigationTitle("Item \(number)")
    }
}
#Preview {
    NavStackView()
}
