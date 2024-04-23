//
//  Home.swift
//  LocationApp
//
//  Created by Nap Works on 25/11/23.
//

import SwiftUI
import MapKit

struct Home: View {
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @Namespace private var locationSpace
    
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResults: [MKMapItem] = []
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition, scope: locationSpace){
                Marker("Apple Park", coordinate: .myLocation)
    //            Annotation("Apple Park", coordinate: .myLocation) {
    //                ZStack {
    //                    Image(systemName: "applelogo")
    //                        .font(.title3)
    //
    //                    Image(systemName: "square")
    //                        .font(.largeTitle)
    //                }
    //            }
    //            .annotationTitles(.hidden)
                
                ForEach(searchResults, id: \.self) {mapItem in
                    let placemark = mapItem.placemark
                    Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                    
                }
                
                UserAnnotation()
            }
            .overlay(alignment: .bottomTrailing) {
                VStack(spacing: 15){
                    MapCompass(scope: locationSpace)
                    MapPitchToggle(scope: locationSpace)
                    MapUserLocationButton(scope: locationSpace)
                }
                .buttonBorderShape(.circle)
                .padding()
            }
            .mapScope(locationSpace)
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, isPresented: $showSearch)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
    //        .mapControls {
    //            MapCompass()
    //            MapUserLocationButton()
    //            MapPitchToggle()
    //        }
        }
        .onSubmit(of: .search) {
            Task {
                guard !searchText.isEmpty else { return }
                await searchPlaces()
            }
        }
    }
    
    func searchPlaces()async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .myRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
}

#Preview {
    ContentView()
}

extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
        return .init(latitude: 32.277384353831664, longitude: 75.51225679933607)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
