//
//  LocationsView.swift
//  MappApp
//
//  Created by Beliz on 6/13/25.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    // A property wrapper type for an observable object that a parent or ancestor view supplies.
    @EnvironmentObject var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
     
    var body: some View {
        ZStack { 
//            Map(position: $vm.mapRegion)
//                .ignoresSafeArea()
                
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationsPreviewStack
            }
        }
        // Presents a sheet using the given item as a data source for the sheet’s content
        // item: binding to an optionals
        // location: current value inside $vm.sheetLocation which is an optional location
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
                .presentationSizing(.page)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }

            if vm.showLocationsList {
                LocationsListView()
            }

        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(position: $vm.mapRegion) {
            ForEach(vm.locations) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(location == vm.mapLocation ? 1 : 0.6 )
                        .onTapGesture {
                            vm.updateLocation(location: location)
                        }
                }
            }
        }
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity )
                        //When this view appears or disappears, the transition will be applied to it
                        .transition(AsymmetricTransition(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading))
                        )
                }
            }
        }
    }
}
