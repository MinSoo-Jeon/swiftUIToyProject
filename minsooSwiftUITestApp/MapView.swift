//
//  MapView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2021/03/17.
//

import MapKit
import SwiftUI

final class CustomMap: NSObject, CLLocationManagerDelegate{
    
    let map = MKMapView()
    let locationManager = CLLocationManager()
    
    func setup(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
    }
}


struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = CustomMap()
        mapView.setup()
        return mapView.map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

