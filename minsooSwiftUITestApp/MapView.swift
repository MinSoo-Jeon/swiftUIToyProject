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
    
    func removeAllAnnotations(){
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func addAnotationList(_ list: [BikeRowData]){
        list.forEach{
            let item = $0
            print(item)
            let point = MKPointAnnotation()
            point.title = item.stationName
            point.subtitle = item.parkingBikeTotCnt + "/" + item.rackTotCnt
            point.coordinate = CLLocationCoordinate2D(latitude: Double(item.latitude) ?? 0.0, longitude: Double(item.longitude) ?? 0.0)
            mapView.addAnnotation(point)
        }
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
            NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name:UIApplication.willEnterForegroundNotification, object: nil)
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                let pLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                let spanValue = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
                let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
                map.setRegion(pRegion, animated: true)
            }
            manager.stopUpdatingLocation()
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }

            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }
            
            if let subtile = annotation.subtitle{
                let subTitleArray = subtile?.split(separator: "/")
                let avalilable = Int(subTitleArray![0]) ?? 0
                if avalilable > 0 {
                    annotationView!.image = UIImage(named: "bikeicon")
                }else{
                    annotationView!.image = UIImage(named: "nobike")
                }
            }else{
                annotationView!.image = UIImage(named: "bikeicon")
            }
            
            return annotationView
        }
        
        @objc func appWillEnterForeground(){
            locationManager.startUpdatingLocation()
        }
    }
}

