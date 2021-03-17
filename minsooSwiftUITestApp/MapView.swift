//
//  MapView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2021/03/17.
//

import MapKit
import SwiftUI


struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate{
        var parent: MapView
        let locationManager = CLLocationManager()
        
        init(_ parent: MapView){
            self.parent = parent
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

