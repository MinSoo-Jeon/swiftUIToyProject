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
    let mapView = MKMapView()

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(mapView)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate{
        let locationManager = CLLocationManager()
        var map: MKMapView
        
        init(_ parent: MKMapView){
            map = parent
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                let pLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                let spanValue = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
                map.setRegion(pRegion, animated: true)
            }
            manager.stopUpdatingLocation()
        }
    }
}

