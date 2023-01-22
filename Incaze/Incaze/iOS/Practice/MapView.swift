//
//  MapView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/27.
//

import MapKit
import SwiftUI
import Foundation
import UIKit


struct MapView: UIViewRepresentable {
    var coordinates = [CLLocationCoordinate2D]()

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Set the map view's region and add the route as an overlay
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        uiView.setRegion(region, animated: true)

        let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
        uiView.addOverlay(route)
    }
}
