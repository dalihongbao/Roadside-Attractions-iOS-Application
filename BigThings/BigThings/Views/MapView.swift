//
//  MapView.swift
//  BigThings
//
//  Created by Yifeng on 25/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import SwiftUI
import MapKit

//This class builds the map view to display the location of each big thing
struct MapView: UIViewRepresentable {
    //The coordinate of a big thing
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    //Overrides the updateUIView function to zoom the map to the big thing
    func updateUIView(_ view: MKMapView, context: Context) {
        //Set the span of the map
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        //Add an annotation to display big thing on the map
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
