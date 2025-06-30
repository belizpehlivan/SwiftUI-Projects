//
//  LocationsViewModel.swift
//  MappApp
//
//  Created by Beliz on 6/13/25.
//

import Foundation
import MapKit
import _MapKit_SwiftUI
import SwiftUICore

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Current region on map
    @Published var mapRegion: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    
    @Published var showLocationsList: Bool = false
    @Published var sheetLocation: Location? = nil   
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(Animation.easeInOut) {
             mapRegion = MapCameraPosition.region(MKCoordinateRegion(
                center:  location.coordinates,
                span: mapSpan)
             )
        }
    }
    
    public func toggleLocationsList() {
        withAnimation(Animation.easeInOut){
            showLocationsList = !showLocationsList
        }
    }
    
    public func updateLocation(location: Location) {
        withAnimation(Animation.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    public func nextButtonPressed() {
        // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array!")
            return
        }
        
        // Check if the current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // Restart from zero
            guard let firstLocation = locations.first else { return }
            updateLocation(location: firstLocation)
            return
        }
        
        // Next index is valid
        let nextLocation = locations[nextIndex]
        updateLocation(location: nextLocation)
    }

}
 

 
