//
//  SecondViewController.swift
//  CoreLocation-Mapkit
//
//  Created by Bahittin on 14.09.2023.
//

import UIKit
import CoreLocation
import MapKit
class SecondViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    let istek = MKLocalSearch.Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        mapView.delegate = self
        searchBar.delegate = self
        
        let konum = CLLocationCoordinate2D(latitude: 37.0143312, longitude: 35.2935563)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let bolge = MKCoordinateRegion(center: konum, span: span)
        
        mapView.setRegion(bolge, animated: true)
        
        istek.region = mapView.region
        
    }
}

extension SecondViewController: MKMapViewDelegate, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        istek.naturalLanguageQuery = searchBar.text!
        
        if mapView.annotations.count > 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        let arama = MKLocalSearch(request: istek)
        
        arama.start { response , error in
            if error != nil {
                print("DEBUG: error is \(error?.localizedDescription)")
                return
            } else if response!.mapItems.count == 0 {
                print("MEKAN YOK")
            } else {
                for mekan in response!.mapItems {
                    
                    if let ad = mekan.name,let tel = mekan.phoneNumber {
                        print("Ad: \(ad)")
                        print("Tel: \(tel)")
                        print("Enlem: \(mekan.placemark.coordinate.latitude)")
                        print("Boylam: \(mekan.placemark.coordinate.longitude)")
                        
                        let pin = MKPointAnnotation()
                        pin.coordinate = mekan.placemark.coordinate
                        pin.title = ad
                        pin.subtitle = tel
                        self.mapView.addAnnotation(pin)
                        self.mapView.showsUserLocation = true
                    }
                }
            }
        }
    }
}
