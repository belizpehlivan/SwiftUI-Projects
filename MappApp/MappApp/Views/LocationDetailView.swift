//
//  LocationDetailView.swift
//  MappApp
//
//  Created by Beliz on 6/23/25.
//

import SwiftUI
import _MapKit_SwiftUI

struct LocationDetailView: View {
    let location: Location
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 16){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
    
}

extension LocationDetailView {
    private  var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
    
    private var mapLayer: some View {
        Map(position:
                .constant(MapCameraPosition.region(MKCoordinateRegion(
                    center: location.coordinates,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)  )
                ))
        ) {
            Annotation(location.name, coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    }
    
    private var backButton: some View {
        Button(action: {
            vm.sheetLocation = nil
        }) {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(.primary)
                .fontWeight(.bold)
                .padding(16)
                .background(.thinMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}
