//
//  BigThingsNearByView.swift
//  BigThings
//
//  Created by Yifeng on 29/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

//This class is used to diaplay the big things nearby
struct BigThingsNearByView: View {
    //Loads the data of all big things
    @ObservedObject var model = PostListViewModel()
    
    var body: some View {
        NearByMapView(things: model.webService.loaded)
    }
}

struct BigThingsNearByView_Previews: PreviewProvider {
    static var previews: some View {
        BigThingsNearByView()
    }
}

//Constructs the map view
struct NearByMapView: UIViewRepresentable {
    var things: [BigThing]
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        //let coordinate = MKUserLocation().coordinate
        let coordinate =  CLLocationCoordinate2D(latitude: CLLocationDegrees(-34.808975), longitude: CLLocationDegrees(138.618674))
        let span = MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        //Displays the current location of the user
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "You are Here"
        view.addAnnotation(annotation)
        //Add all the big things to the map view and display using annotations
        for item in things{
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(item.latitude)!), longitude: CLLocationDegrees(Double(item.longitude)!))
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = item.name
            view.addAnnotation(annotation)
        }
    }
    
}
