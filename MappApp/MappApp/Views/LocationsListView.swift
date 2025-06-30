//
//  LocationsListView.swift
//  MappApp
//
//  Created by Beliz on 6/17/25.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.updateLocation(location: location)
                } label: {
                    listRowView(location: location)
                       
    //                    .onTapGesture(perform: {
    //                        vm.updateLocation(location: location)
    //                    })
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)

            }
        }
        .listStyle(PlainListStyle())
         
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}
 
extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable() //SwiftUI resizes an image to fit its space
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(5)
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                
                Text(location.cityName)
                    .font(.subheadline )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}
